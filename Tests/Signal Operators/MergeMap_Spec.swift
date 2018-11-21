//
//  MergeMap_Spec.swift
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



class MergeMap_Spec: QuickSpec {
    override func spec() {

        var signal: Signal<String, NoError>!
        var observer: Signal<String, NoError>.Observer!
        var observeValues: [String]!

        var scheduler: TestScheduler!

        func signalFor(_ string: String) -> Signal<String, NoError> {
            return Signal { observer, _ in
                scheduler.schedule(after: .seconds(0)) { observer.send(value: string) }
                scheduler.schedule(after: .seconds(1)) { observer.send(value: string + string) }
                scheduler.schedule(after: .seconds(2)) {
                    observer.send(value: string + string + string)
                    observer.sendCompleted()
                }

            }
        }

        beforeEach {

            let (_signal, _observer) = Signal<String, NoError>.pipe()
            signal = _signal
            observer = _observer

            observeValues = []

            scheduler = TestScheduler()

            scheduler.schedule(after: .seconds(0)) { observer.send(value: "A") } // Timing > 0: A, 1: AA, 2: AAA
            scheduler.schedule(after: .seconds(1)) { observer.send(value: "B") } // Timing > 1: B, 2: BB, 3: BBB
            scheduler.schedule(after: .seconds(2)) { observer.send(value: "C") } // Timing > 2: C, 3: CC, 4: CCC

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == ["A", "AA", "B", "AAA", "BB", "C", "BBB", "CC", "CCC"]

        }


        describe("Signal") {
            describe("`mergeMap(with:)`") {

                context("while mapping a Signal") {
                    it("merges values") {

                        signal.mergeMap(with: { signalFor($0) })
                            .observeValues { observeValues.append($0) }

                    }
                }

                context("while mapping a SignalProducer") {
                    it("merges values") {

                        signal.mergeMap(with: { signalFor($0).producer })
                            .observeValues { observeValues.append($0) }

                    }
                }

            }
        }

        describe("SignalProducer") {
            describe("`mergeMap(with:)`") {

                context("while mapping a Signal") {
                    it("merges values") {

                        signal.producer.mergeMap(with: { signalFor($0) })
                            .startWithValues { observeValues.append($0) }

                    }
                }

                context("while mapping a SignalProducer") {
                    it("merges values") {

                        signal.producer.mergeMap(with: { signalFor($0).producer })
                            .startWithValues { observeValues.append($0) }

                    }
                }

            }
        }

    }
}
