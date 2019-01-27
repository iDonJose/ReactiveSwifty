/*:
 ## `MutableActionProperty`
 A mutable property with no default value.
 To use like an action trigger.
 */

import ReactiveSwift
import ReactiveSwifty


/// Mutable action property
let actionProperty = MutableActionProperty<Int>()

/// Initial value
let initialValue = actionProperty.value

actionProperty.producer
    .startWithValues { print("Values : \($0)") }

actionProperty.swap(10)
actionProperty.modify { $0 = $0! * 3 }

/// Clears current value
actionProperty.reset()

/// Final value
let finalValue = actionProperty.value

//: < [Summary](Summary) | [Next](@next) >
