/*:
 ## `toggle()`
 Toggles a MutableProperty of Bool.
 > Method exists for MutableProperty<Bool> & MutableProperty<Bool?>.
 */

import ReactiveSwifty_iOS
import ReactiveSwift
import Result


/// Property
let isLightOn = MutableProperty<Bool>(false)

isLightOn.signal.observeValues {
    if $0 { print("Switched light on") }
    else { print("Switched light off") }
}

isLightOn.toggle()
isLightOn.toggle()

//: < [Summary](Summary) | [Next](@next) >
