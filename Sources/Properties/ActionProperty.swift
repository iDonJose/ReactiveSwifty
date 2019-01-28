//
//  ActionProperty.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 27/01/2019.
//  Copyright © 2019 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



/// A read-only property of type `Value` that allows observation of its changes.
///
/// The property is created with no initial value, as property mimics an action,
/// there is no action triggered at creation.
///
/// Instances of this class are thread-safe.
public final class ActionProperty<Value>: BindingSource {

    /// Underlying property
    private let property: Property<Value?>



    // MARK: - Initialize

    /// Initializes a composed property which reflects the given property.
    ///
    /// - note: The resulting property does not retain the given property.
    ///
    /// - parameters:
    ///   - property: A property to be wrapped.
    public init<P: PropertyProtocol>(_ property: P) where P.Value == Value? {
        self.property = Property(property)
    }

    /// Initializes a composed property which reflects the given property.
    ///
    /// - note: The resulting property does not retain the given property.
    ///
    /// - parameters:
    ///   - property: A property to be wrapped.
    public convenience init(_ property: MutableActionProperty<Value>) {
        self.init(producer: property.producer)
    }

    /// Initializes a composed property that first takes on `initial`, then each
    /// value sent on a signal created by `producer`.
    ///
    /// - parameters:
    ///   - producer: A producer that will start immediately and send values to
    ///             the property.
    public init(producer: SignalProducer<Value?, NoError>) {
        self.property = Property(initial: nil, then: producer)
    }

    /// Initializes a composed property that first takes on `initial`, then each
    /// value sent on a signal created by `producer`.
    ///
    /// - parameters:
    ///   - producer: A producer that will start immediately and send values to
    ///             the property.
    public convenience init(producer: SignalProducer<Value, NoError>) {
        self.init(producer: producer.map { $0 as Value? })
    }

    /// Initializes a composed property that first takes on `initial`, then each
    /// value sent on a signal created by `producer`.
    ///
    /// - parameters:
    ///   - producer: A producer that will start immediately and send values to
    ///             the property.
    public convenience init<Producer: SignalProducerConvertible>(producer: Producer)
        where Producer.Value == Value?, Producer.Error == NoError {

            self.init(producer: producer.producer)
    }

    /// Initializes a composed property that first takes on `initial`, then each
    /// value sent on a signal created by `producer`.
    ///
    /// - parameters:
    ///   - producer: A producer that will start immediately and send values to
    ///             the property.
    public convenience init<Producer: SignalProducerConvertible>(producer: Producer)
        where Producer.Value == Value, Producer.Error == NoError {

            self.init(producer: producer.producer)
    }



    /// The current value of the property.
    public var value: Value? {
        return property.value
    }

    /// A producer for Signals that will send the property's current
    /// value, followed by all changes over time, then complete when the
    /// property has deinitialized or has no further changes.
    ///
    /// - note: If `self` is a composed property, the producer would be
    ///         bound to the lifetime of its sources.
    public var producer: SignalProducer<Value, NoError> {
        return property.producer.skipNil()
    }

    /// A signal that will send the property's changes over time, then
    /// complete when the property has deinitialized or has no further changes.
    ///
    /// - note: If `self` is a composed property, the signal would be
    ///         bound to the lifetime of its sources.
    public var signal: Signal<Value, NoError> {
        return property.signal.skipNil()
    }

}
