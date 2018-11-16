//
//  Completes.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol where Value: EventProtocol, Error == NoError {

    /// Pings any Complete Events.
    public func completes() -> Signal<(), NoError> {
        return signal.filterMap { $0.event.isCompleted ? () : nil }
    }

}


// MARK: - SignalProducer

extension SignalProducerProtocol where Value: EventProtocol, Error == NoError {

    /// Pings any Complete Events.
    public func completes() -> SignalProducer<(), NoError> {
        return producer.lift { $0.completes() }
    }

}
