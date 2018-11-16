/*:
 ## `filter(withLatest:isIncluded:)`
 Filters values according to latest value of another Signal and filter condition.

 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwift
import ReactiveSwifty_iOS


/// Filter condition
func filter(_ string: String) -> Bool {
    return string == "opened"
}


/// Stream of seconds passed by
let timeSpent = SignalProducer((0..<100).map { $0 })
    .spaceOut(by: 1, on: QueueScheduler())

/// SignalProducer used to filter
let producer = SignalProducer(["opened", "closed", "opened", "closed", "opened"])
    .spaceOut(by: 2, on: QueueScheduler())


timeSpent.filter(withLatest: producer, isIncluded: filter)
    .startWithValues { print("> \($0)") }


/*:
 ## `filter(withLatest:)`
 Filters values according to latest value of another Signal of Bool values.

 > Method exists for both Signal & SignalProducer.
 */


/// SignalProducer used to filter
let producer_2 = SignalProducer([true, false, true, false, true])
    .spaceOut(by: 2, on: QueueScheduler())

/* Uncomment to use
timeSpent.filter(withLatest: producer_2)
    .startWithValues { print("> \($0)") }
*/

//: < [Summary](Summary) | [Next](@next) >
