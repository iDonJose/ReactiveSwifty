/*:
 ## `spaceOut(by:on:)`
 Spaces out values by a minimum interval time.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwift
import ReactiveSwifty_iOS


/// Stream of values
let values = SignalProducer((0..<100).map { $0 })

/// Spaces out values
values
    .spaceOut(by: 1, on: QueueScheduler())
    .startWithValues { print("> Value : \($0)") }

//: < [Summary](Summary) | [Next](@next) >
