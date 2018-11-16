//
//  FilterWithLatest_Spec.swift
//  ReactiveSwifty-iOSTests
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import Nimble
import Quick
import ReactiveSwift
@testable import ReactiveSwifty_iOS
import Result



class FilterWithLatest_Spec: QuickSpec {
    override func spec() {

        var signal_1, signal_2: Signal<String, NoError>!
        var observer_1, observer_2: Signal<String, NoError>.Observer!
        var observeValues: [String]!

        var scheduler: TestScheduler!

        func filter(_ string: String) -> Bool {
            return string == "open"
        }

        beforeEach {

            var (signal, observer) = Signal<String, NoError>.pipe()
            signal_1 = signal
            observer_1 = observer

            (signal, observer) = Signal<String, NoError>.pipe()
            signal_2 = signal
            observer_2 = observer

            observeValues = []

            scheduler = TestScheduler()

            scheduler.schedule(after: .seconds(1)) { observer_1.send(value: "A") }
            scheduler.schedule(after: .seconds(2)) { observer_1.send(value: "B") }
            scheduler.schedule(after: .seconds(3)) { observer_1.send(value: "C") }
            scheduler.schedule(after: .seconds(4)) { observer_1.send(value: "D") }
            scheduler.schedule(after: .seconds(5)) { observer_1.send(value: "E") }

            scheduler.schedule(after: .seconds(0)) { observer_2.send(value: "closed") }
            scheduler.schedule(after: .milliseconds(1_500)) { observer_2.send(value: "open") }
            scheduler.schedule(after: .milliseconds(3_500)) { observer_2.send(value: "closed") }
            scheduler.schedule(after: .milliseconds(4_500)) { observer_2.send(value: "open") }

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == ["B", "C", "E"]

        }


        describe("Signal") {
            describe("`filter(withLatest:isIncluded:)`") {

                context("with another Signal") {
                    it("filters values") {

                        signal_1.filter(withLatest: signal_2, isIncluded: filter)
                            .observeValues { observeValues.append($0) }

                    }
                }

                context("with another SignalProducer") {
                    it("filters values") {

                        signal_1.filter(withLatest: signal_2.producer, isIncluded: filter)
                            .observeValues { observeValues.append($0) }

                    }
                }

            }

            describe("`filter(withLatest:)`") {

                context("with another Signal") {
                    it("filters values") {

                        signal_1.filter(withLatest: signal_2.map { filter($0) })
                            .observeValues { observeValues.append($0) }

                    }
                }

                context("with another SignalProducer") {
                    it("filters values") {

                        signal_1.filter(withLatest: signal_2.producer.map { filter($0) })
                            .observeValues { observeValues.append($0) }

                    }
                }

            }
        }

        describe("SignalProducer") {
            describe("`filter(withLatest:isIncluded:)`") {

                context("with another Signal") {
                    it("filters values") {

                        signal_1.producer.filter(withLatest: signal_2, isIncluded: filter)
                            .startWithValues { observeValues.append($0) }

                    }
                }

                context("with another SignalProducer") {
                    it("filters values") {

                        signal_1.producer.filter(withLatest: signal_2.producer, isIncluded: filter)
                            .startWithValues { observeValues.append($0) }

                    }
                }

            }

            describe("`filter(withLatest:)`") {

                context("with another Signal") {
                    it("filters values") {

                        signal_1.producer.filter(withLatest: signal_2.map { filter($0) })
                            .startWithValues { observeValues.append($0) }

                    }
                }

                context("with another SignalProducer") {
                    it("filters values") {

                        signal_1.producer.filter(withLatest: signal_2.producer.map { filter($0) })
                            .startWithValues { observeValues.append($0) }

                    }
                }

            }
        }

    }
}
