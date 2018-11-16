/*:
 ## `Completes`
 Pings on Complete Events.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwifty_iOS
import ReactiveSwift
import Result


/// Stream of events
let producer = SignalProducer<Signal<String, NSError>.Event, NoError> { observer, _ in

    observer.send(value: .value("A"))
    observer.send(value: .value("B"))
    observer.send(value: .completed)
    observer.send(value: .value("C"))
    observer.send(value: .completed)

}
.spaceOut(by: 1, on: QueueScheduler())

/// Observe Complete Events
producer.completes()
    .startWithValues { _ in print("Received a complete event") }

//: < [Summary](Summary) | [Next](@next) >
