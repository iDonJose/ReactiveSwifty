//
//  SkipError_Spec.swift
//  ReactiveSwifty-iOSTests
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import Nimble
import Quick
import ReactiveSwift
@testable import ReactiveSwifty
import Result



class SkipError_Spec: QuickSpec {
    override func spec() {

        var signal: Signal<Int, NSError>!
        var observer: Signal<Int, NSError>.Observer!
        var observeEvents: [String]!

        var scheduler: TestScheduler!

        beforeEach {

            let (_signal, _observer) = Signal<Int, NSError>.pipe()
            signal = _signal
            observer = _observer

            observeEvents = []

            scheduler = TestScheduler()

            let error = NSError(domain: "", code: 0, userInfo: nil)

            scheduler.schedule {
                observer.send(value: 1)
                observer.send(value: 2)
                observer.send(error: error)
                observer.send(value: 3)
            }

        }

        afterEach {

            scheduler.run()
            expect(observeEvents) == ["V1", "V2"]

        }


        describe("Signal") {

            describe("`skipError()`") {
                it("skips error") {

                    signal.skipError()
                        .observeResult { result in
                            switch result {
                            case let .success(value): observeEvents.append("V\(value)")
                            case .failure: observeEvents.append("F")
                            }
                        }

                }
            }

        }

        describe("SignalProducer") {

            describe("`skipError()`") {
                it("skips error") {

                    signal.producer.skipError()
                        .startWithResult { result in
                            switch result {
                            case let .success(value): observeEvents.append("V\(value)")
                            case .failure: observeEvents.append("F")
                            }
                        }

                }
            }

        }

    }
}
