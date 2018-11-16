//
//  Values.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol where Value: EventProtocol, Error == NoError {

    /// Maps value of Value Events.
    public func values() -> Signal<Value.Value, NoError> {

        return signal
            .map { $0.event.value }
            .skipNil()
    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol where Value: EventProtocol, Error == NoError {

    /// Maps value of Value Events.
    public func values() -> SignalProducer<Value.Value, NoError> {
        return producer.lift { $0.values() }
    }

}
