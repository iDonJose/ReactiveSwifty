//
//  SwitchMap.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



// MARK: - Signal

extension SignalProtocol {

    /// Maps each value to a new Signal then switch to latest of these Signals.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A Signal.
    public func switchMap<V>(toLatest transform: @escaping (Value) -> Signal<V, Error>) -> Signal<V, Error> {
        return signal.flatMap(.latest, transform)
    }

    /// Maps each value to a new SignalProducer then switch to latest of these SignalProducers.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A Signal.
    public func switchMap<V>(toLatest transform: @escaping (Value) -> SignalProducer<V, Error>) -> Signal<V, Error> {
        return signal.flatMap(.latest, transform)
    }

}



// MARK: - SignalProducer

public extension SignalProducerProtocol {

    /// Maps each value to a new Signal then switch to latest of these Signals.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A Signal.
    public func switchMap<V>(toLatest transform: @escaping (Value) -> Signal<V, Error>) -> SignalProducer<V, Error> {
        return producer.lift { $0.switchMap(toLatest: transform) }
    }

    /// Maps each value to a new SignalProducer then switch to latest of these SignalProducers.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A Signal.
    public func switchMap<V>(toLatest transform: @escaping (Value) -> SignalProducer<V, Error>) -> SignalProducer<V, Error> {
        return producer.lift { $0.switchMap(toLatest: transform) }
    }

}
