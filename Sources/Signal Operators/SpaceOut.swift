//
//  SpaceOut.swift
//  ReactiveSwifty
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



// MARK: - Signal

extension SignalProtocol {

    /// Spaces out values by a minimum interval time.
    ///
    /// - Parameters:
    ///   - interval: Minimum interval between each sent value.
    ///   - queue: Queue on which delay happens.
    /// - Returns: A SignalProducer.
    public func spaceOut(by interval: TimeInterval,
                         on queue: DateScheduler) -> Signal<Value, Error> {

        return signal.concatMap(with: {
            SignalProducer(value: $0)
                .concat(SignalProducer.empty.delay(interval, on: queue))
        })

    }

}


// MARK: - SignalProducer

extension SignalProducerProtocol {

    /// Spaces out values by a minimum interval time.
    ///
    /// - Parameters:
    ///   - interval: Minimum interval between each sent values.
    ///   - queue: Queue where to delay.
    /// - Returns: A SignalProducer.
    public func spaceOut(by interval: TimeInterval,
                         on queue: DateScheduler) -> SignalProducer<Value, Error> {
        return producer.lift { $0.spaceOut(by: interval, on: queue) }
    }

}
