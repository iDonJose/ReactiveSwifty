/*:
 ## `skipError()`
 Skips error.
 */

import ReactiveSwift
import ReactiveSwifty_iOS
import Result



/// A Signal Producer that will send 2 values and fail.
let producer = SignalProducer<String, NSError> { observer, _ in

    observer.send(value: "🔘 First value")
    observer.send(value: "🔘 Second value")

    print("⚠️ Failed")
    let error = NSError(domain: "", code: 0, userInfo: nil)
    observer.send(error: error)

}

/// Retries on SignalProducer
producer.skipError()
    .startWithResult { result in
        switch result {
        case let .success(value): print(value)
        case .failure: print("⚠️ Failed was received")
        }
    }

//: < [Summary](Summary) | [Next](@next) >
