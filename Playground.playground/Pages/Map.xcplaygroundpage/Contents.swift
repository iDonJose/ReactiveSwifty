/*:
 ## `mapValue(:)`
 Always maps to the same value.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwift
import ReactiveSwifty


/// Stream of inputs
let inputs = SignalProducer((0..<100).map { $0 })
    .spaceOut(by: 1, on: QueueScheduler())

inputs.map(value: "Constant")
    .startWithValues { print("Value: \($0)") }


/*:
 ## `mapVoid()`
 Always maps Void.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwift
import ReactiveSwifty

/* Uncomment to use
inputs.mapVoid()
    .startWithValues { print("Value: \($0)") }
 */

//: < [Summary](Summary) | [Next](@next) >
