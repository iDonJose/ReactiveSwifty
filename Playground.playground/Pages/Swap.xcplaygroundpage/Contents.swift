/*:
 ## `<> (swap)`
 Swaps new value
 */

import ReactiveSwift
import ReactiveSwifty


/// Atomic
let atomic = Atomic<Bool>(false)

atomic <> true
atomic <> true


/// MutableProperty
let property = MutableProperty<Bool>(false)

property <> true
property <> true


/// MutableActionProperty
let actionProperty = MutableActionProperty<Bool>()

actionProperty <> true
actionProperty <> true


//: < [Summary](Summary) | [Next](@next) >
