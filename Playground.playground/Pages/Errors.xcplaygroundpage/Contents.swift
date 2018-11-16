/*:
 ## `Errors`
 Maps error of Error Events.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwifty
import ReactiveSwift
import Result


/// Stream of events
let producer = SignalProducer<Signal<String, NSError>.Event, NoError> { observer, _ in

    observer.send(value: .value("A"))
    observer.send(value: .value("B"))
    observer.send(value: .failed(NSError()))
    observer.send(value: .value("C"))
    observer.send(value: .failed(NSError()))

}
.spaceOut(by: 1, on: QueueScheduler())

/// Observe Error Events
producer.errors()
    .startWithValues { _ in print("Received an error") }

//: < [Summary](Summary) | [Next](@next) >
