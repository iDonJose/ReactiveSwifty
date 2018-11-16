//
//  FilterWithLatest.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol {

    /// Filters values send by self when latest value from other Signal doesn't fulfill condition.
    ///
    /// - Parameters:
    ///   - other: Other Signal which value is used to check condition.
    ///   - isIncluded: Condition that latest value must fulfill to include value of self.
    /// - Returns: A filtered Signal.
    public func filter<V>(withLatest other: Signal<V, NoError>,
                          isIncluded: @escaping (V) -> Bool) -> Signal<Value, Error> {

        return signal.combine(withLatest: other)
            .filter { isIncluded($0.1) }
            .map { $0.0 }
    }

    /// Filters values send by self when latest value from other SignalProducer doesn't fulfill condition.
    ///
    /// - Parameters:
    ///   - other: Other SignalProducer which value is used to check condition.
    ///   - isIncluded: Condition that latest value must fulfill to include value of self.
    /// - Returns: A filtered Signal.
    public func filter<V>(withLatest other: SignalProducer<V, NoError>,
                          isIncluded: @escaping (V) -> Bool) -> Signal<Value, Error> {

        return signal.combine(withLatest: other)
            .filter { isIncluded($0.1) }
            .map { $0.0 }
    }


    /// Filters values send by self when latest value from other Signal is false.
    ///
    /// - Parameters:
    ///   - other: Other Signal which boolean value means that self's value is included.
    /// - Returns: A filtered Signal.
    public func filter(withLatest other: Signal<Bool, NoError>) -> Signal<Value, Error> {
        return signal.filter(withLatest: other, isIncluded: { $0 })
    }

    /// Filters values send by self when latest value from other SignalProducer is false.
    ///
    /// - Parameters:
    ///   - other: Other SignalProducer which boolean value means that self's value is included.
    /// - Returns: A filtered Signal.
    public func filter(withLatest other: SignalProducer<Bool, NoError>) -> Signal<Value, Error> {
        return signal.filter(withLatest: other, isIncluded: { $0 })
    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol {

    /// Filters values send by self when latest value from other Signal doesn't fulfill condition.
    ///
    /// - Parameters:
    ///   - other: Other Signal which value is used to check condition.
    ///   - isIncluded: Condition that latest value must fulfill to include value of self.
    /// - Returns: A filtered SignalProducer.
    public func filter<V>(withLatest other: Signal<V, NoError>,
                          isIncluded: @escaping (V) -> Bool) -> SignalProducer<Value, Error> {
        return producer.lift { $0.filter(withLatest: other, isIncluded: isIncluded) }
    }

    /// Filters values send by self when latest value from other SignalProducer doesn't fulfill condition.
    ///
    /// - Parameters:
    ///   - other: Other SignalProducer which value is used to check condition.
    ///   - isIncluded: Condition that latest value must fulfill to include value of self.
    /// - Returns: A filtered SignalProducer.
    public func filter<V>(withLatest other: SignalProducer<V, NoError>,
                          isIncluded: @escaping (V) -> Bool) -> SignalProducer<Value, Error> {
        return producer.lift { $0.filter(withLatest: other, isIncluded: isIncluded) }
    }


    /// Filters values send by self when latest value from other Signal is false.
    ///
    /// - Parameters:
    ///   - other: Other Signal which boolean value means that self's value is included.
    /// - Returns: A filtered SignalProducer.
    public func filter(withLatest other: Signal<Bool, NoError>) -> SignalProducer<Value, Error> {
        return producer.lift { $0.filter(withLatest: other) }
    }

    /// Filters values send by self when latest value from other SignalProducer is false.
    ///
    /// - Parameters:
    ///   - other: Other SignalProducer which boolean value means that self's value is included.
    /// - Returns: A filtered SignalProducer.
    public func filter(withLatest other: SignalProducer<Bool, NoError>) -> SignalProducer<Value, Error> {
        return producer.lift { $0.filter(withLatest: other) }
    }

}
