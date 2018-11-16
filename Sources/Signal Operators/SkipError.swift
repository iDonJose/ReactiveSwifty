//
//  SkipError.swift
//  ReactiveSwifty
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol {

    /// Skips error emitted by Signal.
    ///
    /// - Returns: A non-failing Signal.
    public func skipError() -> Signal<Value, NoError> {
        return signal.flatMapError { _ in SignalProducer.empty }
    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol {

    /// Skips error emitted by SignalProducer.
    ///
    /// - Returns: A non-failing SignalProducer.
    public func skipError() -> SignalProducer<Value, NoError> {
        return producer.lift { $0.skipError() }
    }

}
