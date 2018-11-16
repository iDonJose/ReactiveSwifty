//
//  Retry.swift
//  ReactiveSwifty
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift



extension SignalProducerProtocol {

    /// Retries when SignalProducer failed, spacing out retries by a minimum interval.
    ///
    /// - Parameters:
    ///   - interval: Minimum interval between each retry.
    ///   - count: Retry count.
    ///   - queue: Queue on which delay happens.
    /// - Returns: A SignalProducer.
    ///
    /// This methods is just remapping `retry(upTo:interval:on:)` from `ReactiveSwift` under the hood.
    public func retry(every interval: TimeInterval,
                      upTo count: Int,
                      on queue: DateScheduler) -> SignalProducer<Value, Error> {
        return producer.retry(upTo: count, interval: interval, on: queue)
    }

    /// Retries indefinitely when SignalProducer failed, spacing out retries by a minimum interval.
    ///
    /// - Parameters:
    ///   - interval: Minimum interval between each retry.
    ///   - queue: Queue on which delay happens.
    /// - Returns: A SignalProducer.
    public func retry(every interval: TimeInterval,
                      on queue: DateScheduler) -> SignalProducer<Value, Error> {

        return producer.flatMapError { _ in

            return SignalProducer<Value, Error>.empty
                .delay(interval, on: queue)
                .concat(self.retry(every: interval, on: queue))
        }

    }

}
