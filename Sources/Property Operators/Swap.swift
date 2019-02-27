//
//  Swap.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 27/02/2019.
//  Copyright © 2019 iDonJose. All rights reserved.
//

import ReactiveSwift



infix operator <>: AssignmentPrecedence


/// Swaps new value
@discardableResult
public func <> <Value>(property: Atomic<Value>, value: Value) -> Value {
    return property.swap(value)
}

/// Swaps new value
@discardableResult
public func <> <Value>(property: MutableProperty<Value>, value: Value) -> Value {
    return property.swap(value)
}

/// Swaps new value
@discardableResult
public func <> <Value>(property: MutableActionProperty<Value>, value: Value) -> Value? {
    return property.swap(value)
}
