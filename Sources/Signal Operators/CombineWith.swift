//
//  CombineWith.swift
//  ReactiveSwiftyTests
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol {

    /// Combines latest values of self and another Signal.
    ///
    /// This methods is just remapping `retry(upTo:interval:on:)` from `ReactiveSwift` under the hood.
    public func combine<V>(with other: Signal<V, Error>) -> Signal<(Value, V), Error> {
        return signal.combineLatest(with: other)
    }

    /// Combines latest values of self and another SignalProducer.
    ///
    /// This methods is just remapping `retry(upTo:interval:on:)` from `ReactiveSwift` under the hood.
    public func combine<V>(with other: SignalProducer<V, Error>) -> Signal<(Value, V), Error> {
        return other.startWithSignal { other, lifetime in
            signal
                .combineLatest(with: other)
                .on(disposed: { lifetime.dispose() })
        }
    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol {

    /// Combines latest values of self and another Signal.
    ///
    /// This methods is just remapping `retry(upTo:interval:on:)` from `ReactiveSwift` under the hood.
    public func combine<V>(with other: Signal<V, Error>) -> SignalProducer<(Value, V), Error> {
        return producer.combineLatest(with: other.producer)
    }

    /// Combines latest values of self and another SignalProducer.
    ///
    /// This methods is just remapping `retry(upTo:interval:on:)` from `ReactiveSwift` under the hood.
    public func combine<V>(with other: SignalProducer<V, Error>) -> SignalProducer<(Value, V), Error> {
        return producer.combineLatest(with: other)
    }

}
