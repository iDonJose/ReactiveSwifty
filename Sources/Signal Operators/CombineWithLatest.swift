//
//  CombineWithLatest.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



// MARK: - Signal

extension SignalProtocol {

    /// Combines each value of self with the latest value of another Signal, if there is one.
    public func combine<V>(withLatest other: Signal<V, NoError>) -> Signal<(Value, V), Error> {
        return combine(withLatest: SignalProducer(other))
    }

    /// Combines each value of self with the latest value of another SignalProducer, if there is one.
    public func combine<V>(withLatest other: SignalProducer<V, NoError>) -> Signal<(Value, V), Error> {

        return Signal { observer, lifetime in

            let otherValue = Atomic<V?>(nil)


            lifetime += other.start { event in
                switch event {

                case let .value(value): otherValue.swap(value)
                case .failed, .completed, .interrupted: break

                }
            }


            lifetime += signal.observe { event in
                switch event {

                case let .value(value):
                    if let otherValue = otherValue.value {
                        observer.send(value: (value, otherValue))
                    }
                case let .failed(error): observer.send(error: error)
                case .completed: observer.sendCompleted()
                case .interrupted: observer.sendInterrupted()

                }
            }

        }

    }

}



// MARK: - SignalProducer

extension SignalProducerProtocol {

    /// Combines each value of self with the latest value of another Signal, if there is one.
    public func combine<V>(withLatest other: Signal<V, NoError>) -> SignalProducer<(Value, V), Error> {
        return producer.lift { $0.combine(withLatest: other) }
    }

    /// Combines each value of self with the latest value of another SignalProducer, if there is one.
    public func combine<V>(withLatest other: SignalProducer<V, NoError>) -> SignalProducer<(Value, V), Error> {
        return producer.lift { $0.combine(withLatest: other) }
    }

}
