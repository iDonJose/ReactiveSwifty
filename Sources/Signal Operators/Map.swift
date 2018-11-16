//
//  Map.swift
//  ReactiveSwifty
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



// MARK: - Signal

extension SignalProtocol {

    /// Maps to a specific value.
    public func mapValue<T>(_ value: T) -> Signal<T, Error> {
        return signal.map { _ in value }
    }

    /// Maps to void.
    public func mapVoid() -> Signal<(), Error> {
        return signal.map { _ in () }
    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol {

    /// Maps to a predifined value.
    public func mapValue<T>(_ value: T) -> SignalProducer<T, Error> {
        return producer.lift { $0.mapValue(value) }
    }

    /// Maps to void.
    public func mapVoid() -> SignalProducer<(), Error> {
        return producer.lift { $0.mapVoid() }
    }

}
