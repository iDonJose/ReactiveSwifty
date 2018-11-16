/*:
 ## `combine(withLatest:)`
 Combines value sent by a Signal with latest value of another Signal.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwift
import ReactiveSwifty


/// A stream of unread mails count that increase over time
let unreadMails = SignalProducer((1..<100).map { Double($0) })
    .spaceOut(by: 0.5, on: QueueScheduler())
    .map { Int(200 * (1 - 1 / pow($0, 0.1))) }

/// Checks mails count on a time basis
SignalProducer
    .timer(interval: .seconds(1), on: QueueScheduler())
    .combine(withLatest: unreadMails)
    .startWithValues { print("> There are \($0.1) unread mails") }

//: < [Summary](Summary) | [Next](@next) >
