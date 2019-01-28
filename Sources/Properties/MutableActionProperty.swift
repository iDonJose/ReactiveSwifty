//
//  MutableActionProperty.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 26/01/2019.
//  Copyright © 2019 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



/// A mutable property of type `Value` that allows observation of its changes.
///
/// The property is created with no initial value, as property mimics an action,
/// there is no action triggered at creation.
///
/// Instances of this class are thread-safe.
public final class MutableActionProperty<Value>: BindingSource, BindingTargetProvider {

    /// Underlying property
    private let property = MutableProperty<Value?>(nil)



    // MARK: - Initialize

    public init() {}



    /// The current value of the property.
    ///
    /// Setting this to a new value will notify all observers of `signal`, or
    /// signals created using `producer`.
    ///
    /// - Important: Setting a nil value has no effet. See `reset()` to discard value.
    public var value: Value? {
        get { return property.value }
        set {
            if newValue != nil {
                property.modify { $0 = newValue }
            }
        }
    }

    /// The lifetime of the property.
    public var lifetime: Lifetime {
        return property.lifetime
    }

    /// A signal that will send the property's changes over time,
    /// then complete when the property has deinitialized.
    public var signal: Signal<Value, NoError> {
        return property.signal.skipNil()
    }

    /// A producer for Signals that will send the property's current value,
    /// followed by all changes over time, then complete when the property has
    /// deinitialized.
    public var producer: SignalProducer<Value, NoError> {
        return property.producer.skipNil()
    }

    public var bindingTarget: BindingTarget<Value> {
        return BindingTarget(lifetime: lifetime) { [weak self] in self?.value = $0 }
    }



    /// Resets property to have no value.
    ///
    /// - Returns: Previous value.
    @discardableResult
    public func reset() -> Value? {
        return property.swap(nil)
    }

    /// Atomically replaces the contents of the variable.
    ///
    /// - parameters:
    ///   - newValue: New property value.
    ///   - default: Default value to set in case there was no previous value
    ///
    /// - returns: The previous property value.
    @discardableResult
    public func swap(_ newValue: Value) -> Value? {
        return modify { value in
            defer { value = newValue }
            return value
        }
    }

    /// Atomically modifies the variable.
    ///
    /// - parameters:
    ///   - default: Default value to set in case there was no previous value
    ///   - action: A closure that accepts an inout reference to the value.
    ///
    /// - returns: The result of the action.
    ///
    /// - Important : If there is no initial value, result will be nil.
    @discardableResult
    public func modify<Result>(_ action: (inout Value?) throws -> Result) rethrows -> Result {
        return try property.modify { try action(&$0) }
    }

    /// Atomically performs an arbitrary action using the current value of the
    /// variable.
    ///
    /// - parameters:
    ///   - action: A closure that accepts current property value.
    ///
    /// - returns: the result of the action.
    ///
    /// - Important : If there is no initial value, action closure won't be executed and returned value will be nil.
    @discardableResult
    public func withValue<Result>(_ action: (Value?) throws -> Result) rethrows -> Result {
        return try property.withValue { try action($0!) }
    }

}
