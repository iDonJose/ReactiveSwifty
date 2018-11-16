//
//  LifetimeProvider.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



/// By conforming to *LifetimeProvider* the object provides a lifetime property
/// which gives a chance to react to object deinitialization.
///
/// The property has a default implementation when conforming to *LifetimeProvider*.
public protocol LifetimeProvider {

    /// Lifetime
    var lifetime: Lifetime { get }

}



private var key: UInt8 = 0

extension LifetimeProvider {

    public var lifetime: Lifetime { return Lifetime(token) }

    private var token: Lifetime.Token {
        if let token = objc_getAssociatedObject(self, &key) as? Lifetime.Token { return token }
        else {
            let token = Lifetime.Token()
            objc_setAssociatedObject(self, &key, token, .OBJC_ASSOCIATION_RETAIN)
            return token
        }
    }

}
