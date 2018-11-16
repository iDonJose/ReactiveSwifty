/*:
 ## `LifetimeProvider`
 Adds a `Lifetime` property to an object which in turn helps to observe object deinitialization.
 */

import ReactiveSwifty_iOS



class Object: LifetimeProvider {}

/// An object conforming to `LifetimeProvider`
var object: Object! = Object()
/// Lifetime property of the object
let lifetime = object.lifetime


lifetime.observeEnded {
    print("Object has been deinitialised")
}

/// Releases object
object = nil

//: < [Summary](Summary) | [Next](@next) >
