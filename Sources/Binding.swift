//
//  Binding.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



/// Binds a Signal to an Observer.
///
/// - Returns: A Disposable.
@discardableResult
public func <~ <Value, Error>(observer: Signal<Value, Error>.Observer, signal: Signal<Value, Error>) -> Disposable? {

    return signal.observe(observer)

}


/// Binds a SignalProducer to an Observer.
///
/// - Returns: A Disposable.
@discardableResult
public func <~ <Value, Error>(observer: Signal<Value, Error>.Observer, producer: SignalProducer<Value, Error>) -> Disposable {

    return producer.start(observer)

}
