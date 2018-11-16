/*:
 ## `retry(every:on:)`
 Retries on failing, spacing out retries by a minimum interval.
 */

import ReactiveSwift
import ReactiveSwifty
import Result


/// Tracks failed count
var failCount = 0

/// A Signal Producer that will send 2 values and fail after the first one for the first 3 attempts.
let producer = SignalProducer<String, NSError> { observer, _ in

    observer.send(value: "🔘 First value")

    if failCount >= 3 { observer.send(value: "🔘 Last value !") }
    else {
        print("⚠️ Failed")
        failCount += 1

        let error = NSError(domain: "", code: 0, userInfo: nil)
        observer.send(error: error)
    }
    
}

/// Retries on SignalProducer
producer.retry(every: 1,
               on: QueueScheduler())
    .startWithResult { result in
        switch result {
        case let .success(value): print(value)
        case .failure: print("⚠️ Failed after all retries")
        }
    }

//: < [Summary](Summary) | [Next](@next) >
