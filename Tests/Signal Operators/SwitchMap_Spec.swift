//
//  SwitchMap_Spec.swift
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



class SwitchMap_Spec: QuickSpec {
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
            scheduler.schedule(after: .seconds(3)) { observer.send(value: "C") } // Timing > 3: C, 4: CC, 5: CCC

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == ["A", "B", "BB", "C", "CC", "CCC"]

        }


        describe("Signal") {
            describe("`switchMap(toLatest:)`") {

                context("while mapping a Signal") {
                    it("switches to values of latest Signal") {

                        signal.switchMap(toLatest: { signalFor($0) })
                            .observeValues { observeValues.append($0) }

                    }
                }

                context("while mapping a SignalProducer") {
                    it("switches to values of latest SignalProducer") {

                        signal.switchMap(toLatest: { signalFor($0).producer })
                            .observeValues { observeValues.append($0) }

                    }
                }

            }
        }

        describe("SignaProducer") {
            describe("`switchMap(toLatest:)`") {

                context("while mapping a Signal") {
                    it("switches to values of latest Signal") {

                        signal.producer.switchMap(toLatest: { signalFor($0) })
                            .startWithValues { observeValues.append($0) }

                    }
                }

                context("while mapping a SignalProducer") {
                    it("switches to values of latest SignalProducer") {

                        signal.producer.switchMap(toLatest: { signalFor($0).producer })
                            .startWithValues { observeValues.append($0) }

                    }
                }

            }
        }

    }
}
