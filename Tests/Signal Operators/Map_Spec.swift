//
//  Map_Spec.swift
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



class Map_Spec: QuickSpec {
    override func spec() {

        var signal: Signal<String, NoError>!
        var observer: Signal<String, NoError>.Observer!
        var observeValues: [String]!

        var scheduler: TestScheduler!

        beforeEach {

            let (_signal, _observer) = Signal<String, NoError>.pipe()
            signal = _signal
            observer = _observer

            observeValues = []

            scheduler = TestScheduler()

            scheduler.schedule {
                observer.send(value: "A")
                observer.send(value: "B")
                observer.send(value: "C")
            }

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == ["S", "S", "S"]

        }

        describe("Signal") {
            describe("`mapValue(:)`") {

                it("maps always the same value") {

                    signal.mapValue("S")
                        .observeValues { observeValues.append($0) }

                }

            }

            describe("`mapVoid()`") {

                it("maps always Void") {

                    signal.mapVoid()
                        .observeValues { if $0 == () { observeValues.append("S") } }

                }

            }
        }

        describe("SignalProducer") {
            describe("`mapValue(:)`") {

                it("maps always the same value") {

                    signal.producer.mapValue("S")
                        .startWithValues { observeValues.append($0) }

                }

            }

            describe("`mapVoid()`") {

                it("maps always Void") {

                    signal.producer.mapVoid()
                        .startWithValues { if $0 == () { observeValues.append("S") } }

                }

            }
        }

    }
}
