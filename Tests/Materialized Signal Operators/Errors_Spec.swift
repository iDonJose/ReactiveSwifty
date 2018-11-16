//
//  Errors_Spec.swift
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



class Errors_Spec: QuickSpec {
    override func spec() {

        var signal: Signal<Signal<String, NSError>.Event, NoError>!
        var observer: Signal<Signal<String, NSError>.Event, NoError>.Observer!
        var observeValues: Int!

        var scheduler: TestScheduler!

        beforeEach {

            let (_signal, _observer) = Signal<Signal<String, NSError>.Event, NoError>.pipe()
            signal = _signal
            observer = _observer

            observeValues = 0

            scheduler = TestScheduler()

            scheduler.schedule(after: .seconds(1)) { observer.send(value: .value("A")) }
            scheduler.schedule(after: .seconds(2)) { observer.send(value: .completed) }
            scheduler.schedule(after: .seconds(3)) { observer.send(value: .failed(NSError())) }
            scheduler.schedule(after: .seconds(4)) { observer.send(value: .value("B")) }
            scheduler.schedule(after: .seconds(5)) { observer.send(value: .failed(NSError())) }

        }

        afterEach {

            scheduler.advance()
            expect(observeValues) == 0

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 0

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 0

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 1

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 1

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 2

        }


        describe("Signal") {
            describe("`errors()`") {
                it("forwards only errors") {

                    signal.errors()
                        .observeValues { _ in observeValues += 1 }

                }
            }
        }

        describe("SignalProducer") {
            describe("`errors()`") {
                it("forwards only errors") {

                    signal.producer.errors()
                        .startWithValues { _ in observeValues += 1 }

                }
            }
        }

    }
}
