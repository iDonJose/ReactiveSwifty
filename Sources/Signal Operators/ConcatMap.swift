//
//  ConcatMap.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



// MARK: - Signal

extension SignalProtocol {

    /// Maps each value to a new Signal then concats these Signals.
    /// These Signals will start after one an other, when the previous one has completed.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A Signal.
    public func concatMap<V>(with transform: @escaping (Value) -> Signal<V, Error>) -> Signal<V, Error> {
        return signal.flatMap(.concat, transform)
    }

    /// Maps each value to a new SignalProducer then concats these SignalProducers.
    /// These SignalProducers will start after one an other, when the previous one has completed.
    ///
    /// - Parameter transform: Transform block mapping value to a SignalProducer.
    /// - Returns: A Signal.
    public func concatMap<V>(with transform: @escaping (Value) -> SignalProducer<V, Error>) -> Signal<V, Error> {
        return signal.flatMap(.concat, transform)
    }

}



// MARK: - SignalProducer

public extension SignalProducerProtocol {

    /// Maps each value to a new Signal then concats these Signals.
    /// These Signals will start after one an other, when the previous one has completed.
    ///
    /// - Parameter transform: Transform block mapping value to a Signal.
    /// - Returns: A SignalProducer.
    public func concatMap<V>(with transform: @escaping (Value) -> Signal<V, Error>) -> SignalProducer<V, Error> {
        return producer.lift { $0.concatMap(with: transform) }
    }

    /// Maps each value to a new SignalProducer then concats these SignalProducers.
    /// These SignalProducers will start after one an other, when the previous one has completed.
    ///
    /// - Parameter transform: Transform block mapping value to a SignalProducer.
    /// - Returns: A SignalProducer.
    public func concatMap<V>(with transform: @escaping (Value) -> SignalProducer<V, Error>) -> SignalProducer<V, Error> {
        return producer.lift { $0.concatMap(with: transform) }
    }

}
