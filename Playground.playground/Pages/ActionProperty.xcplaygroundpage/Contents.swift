/*:
 ## `ActionProperty`
 A read-only property with no default value.
 To use like an action trigger.
 */

import ReactiveSwift
import ReactiveSwifty


let producer = SignalProducer([Int?](arrayLiteral: nil, nil, 1, 2, nil, 4, nil, 6, 7))
    .spaceOut(by: 0.5, on: QueueScheduler())

/// Action property
let actionProperty = ActionProperty<Int>(producer: producer)

actionProperty.producer
    .startWithValues { print("Values : \($0)") }


//: < [Summary](Summary) | [Next](@next) >
