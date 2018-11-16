/*:
 ## `switchMap(toLatest:)`
 Maps each value to a new Signal then switch to latest of these Signals.
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
    .spaceOut(by: 1.1, on: QueueScheduler())
}

/// Stream of items
let items = SignalProducer(["iWatch", "iPhone", "iPad"])
    .spaceOut(by: 1, on: QueueScheduler())

/// Run actions on items
items
    .switchMap(toLatest: { actions($0) })
    .startWithValues { print("\($0)") }

//: < [Summary](Summary) | [Next](@next) >
