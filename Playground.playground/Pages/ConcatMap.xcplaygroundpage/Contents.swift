/*:
 ## `concatMap(with:)`
 Maps each value to a Signal then concats theses Signals.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwift
import ReactiveSwifty
import Result


/// A stream of actions with item
let actions: (String) -> SignalProducer<String, NoError> = { item in
    return SignalProducer([
        "1. Unpack \(item)",
        "2. Plug \(item)",
        "3. Run \(item)"
    ])
}

/// Stream of items
let items = SignalProducer(["iWatch", "iPhone", "iPad"])
    .spaceOut(by: 1, on: QueueScheduler())

/// Run actions on items
items
    .concatMap(with: { actions($0) })
    .startWithValues { print("\($0)") }

//: < [Summary](Summary) | [Next](@next) >
