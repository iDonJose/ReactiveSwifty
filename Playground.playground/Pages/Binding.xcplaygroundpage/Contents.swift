/*:
 ## `Binding (<~)`
 Binds a Signal and an Observer.
 > Method exists for both Signal & SignalProducer.
 */

import ReactiveSwifty_iOS
import ReactiveSwift
import Result


/// Stream of values
let producer = SignalProducer((0..<100).map { $0 })
    .spaceOut(by: 0.5, on: QueueScheduler())

/// Observer of values
let observer = Signal<Int, NoError>.Observer(value: {
    print("Observed value : \($0)")
})


/// Binds producer to observer
observer <~ producer

//: < [Summary](Summary) | [Next](@next) >
