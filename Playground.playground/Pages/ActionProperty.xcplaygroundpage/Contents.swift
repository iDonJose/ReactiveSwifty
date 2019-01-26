/*:
 ## `ActionProperty`
 A mutable property with no default value.
 To use like an action trigger.
 */

import ReactiveSwift
import ReactiveSwifty


/// Action property
let actionProperty = ActionProperty<Int>()

/// Initial value
let initialValue = actionProperty.value

actionProperty.producer
    .startWithValues { print("Values : \($0)") }

actionProperty.swap(10, default: 20)
actionProperty.modify(default: 5) { $0 = $0 * 3 }

/// Clears current value
actionProperty.reset()

/// Final value
let finalValue = actionProperty.value

//: < [Summary](Summary) | [Next](@next) >
