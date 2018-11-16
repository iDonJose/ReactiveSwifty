//
//  CombineWithLatest_Spec.swift
//  ReactiveSwifty-iOSTests
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

@testable import ReactiveSwifty_iOS
import Nimble
import Quick
import ReactiveSwift
import Result



class CombineWithLatest_Spec: QuickSpec {
    override func spec() {

        var signal_1, signal_2: Signal<Int, NoError>!
        var observer_1, observer_2: Signal<Int, NoError>.Observer!
        var observeValue_1, observeValue_2: Int?

        var scheduler: TestScheduler!

        beforeEach {

            var (signal, observer) = Signal<Int, NoError>.pipe()
            signal_1 = signal
            observer_1 = observer

            (signal, observer) = Signal<Int, NoError>.pipe()
            signal_2 = signal
            observer_2 = observer

            observeValue_1 = nil
            observeValue_2 = nil

            scheduler = TestScheduler()

            scheduler.schedule(after: .seconds(1)) { observer_1.send(value: 10) }
            scheduler.schedule(after: .seconds(2)) { observer_2.send(value: 20) }
            scheduler.schedule(after: .seconds(3)) { observer_1.send(value: 11) }
            scheduler.schedule(after: .seconds(4)) { observer_1.send(value: 12) }
            scheduler.schedule(after: .seconds(5)) { observer_2.send(value: 21) }

        }

        afterEach {

            scheduler.advance()

            expect(observeValue_1).to(beNil())
            expect(observeValue_2).to(beNil())

            scheduler.advance(by: .seconds(1))
            // signal_2 must have at least sent a value
            expect(observeValue_1).to(beNil())
            expect(observeValue_2).to(beNil())

            scheduler.advance(by: .seconds(1))

            expect(observeValue_1).to(beNil())
            expect(observeValue_2).to(beNil())

            scheduler.advance(by: .seconds(1))

            expect(observeValue_1) == 11
            expect(observeValue_2) == 20

            scheduler.advance(by: .seconds(1))

            expect(observeValue_1) == 12
            expect(observeValue_2) == 20

            scheduler.advance(by: .seconds(1))
            // signal_2 shouldn't trigger any new values
            expect(observeValue_1) == 12
            expect(observeValue_2) == 20

        }


        describe("Signal") {
            describe("`combine(withLatest:)`") {

                context("with another Signal") {
                    it("combines sent value with other's latest value") {

                        signal_1.combine(withLatest: signal_2)
                            .observeValues {
                                observeValue_1 = $0.0
                                observeValue_2 = $0.1
                        }

                    }
                }

                context("with another SignalProducer") {
                    it("combines sent value with other's latest value") {

                        signal_1.combine(withLatest: signal_2.producer)
                            .observeValues {
                                observeValue_1 = $0.0
                                observeValue_2 = $0.1
                        }

                    }
                }
            }
        }

        describe("SignalProducer") {
            describe("`combine(withLatest:)`") {

                context("with another Signal") {
                    it("combines sent value with other's latest value") {

                        signal_1.producer.combine(withLatest: signal_2)
                            .startWithValues {
                                observeValue_1 = $0.0
                                observeValue_2 = $0.1
                            }

                    }
                }

                context("with another SignalProducer") {
                    it("combines sent value with other's latest value") {

                        signal_1.producer.combine(withLatest: signal_2.producer)
                            .startWithValues {
                                observeValue_1 = $0.0
                                observeValue_2 = $0.1
                            }

                    }
                }
            }
        }

    }
}
