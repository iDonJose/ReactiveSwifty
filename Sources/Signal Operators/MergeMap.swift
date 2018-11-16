//
//  MergeMap.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



// MARK: - Signal

extension SignalProtocol {

    /// Maps each value to a new Signal then merges these Signals.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A Signal.
    public func mergeMap<V>(with transform: @escaping (Value) -> Signal<V, Error>) -> Signal<V, Error> {
        return signal.flatMap(.merge, transform)
    }

    /// Maps each value to a new SignalProducer then merges these SignalProducers.
    ///
    /// - Parameter transform: Transform block mapping value to a SignalProducer.
    /// - Returns: A Signal.
    public func mergeMap<V>(with transform: @escaping (Value) -> SignalProducer<V, Error>) -> Signal<V, Error> {
        return signal.flatMap(.merge, transform)
    }

}



// MARK: - SignalProducer

public extension SignalProducerProtocol {

    /// Maps each value to a new Signal then merges these Signals.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A SignalProducer.
    public func mergeMap<V>(with transform: @escaping (Value) -> Signal<V, Error>) -> SignalProducer<V, Error> {
        return producer.lift { $0.mergeMap(with: transform) }
    }

    /// Maps each value to a new SignalProducer then merges these SignalProducers.
    ///
    /// - Parameter transform: Transform block mapping value to a SignalProducer.
    /// - Returns: A SignalProducer.
    public func mergeMap<V>(with transform: @escaping (Value) -> SignalProducer<V, Error>) -> SignalProducer<V, Error> {
        return producer.lift { $0.mergeMap(with: transform) }
    }

}
