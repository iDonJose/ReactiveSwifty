//
//  Errors.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol where Value: EventProtocol, Error == NoError {

    /// Maps errors of Error Events.
    public func errors() -> Signal<Value.Error, NoError> {

        return signal
            .map { $0.event.error }
            .skipNil()
    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol where Value: EventProtocol, Error == NoError {

    /// Maps errors of Error Events.
    public func errors() -> SignalProducer<Value.Error, NoError> {
        return producer.lift { $0.errors() }
    }

}
