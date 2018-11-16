//
//  Values_Spec.swift
//  ReactiveSwifty-iOSTests
//
//  Created by José Donor on 16/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

@testable import ReactiveSwifty_iOS
import Nimble
import Quick
import ReactiveSwift
import Result



class Values_Spec: QuickSpec {
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

            scheduler.schedule(after: .seconds(1)) { observer.send(value: .completed) }
            scheduler.schedule(after: .seconds(2)) { observer.send(value: .value("A")) }
            scheduler.schedule(after: .seconds(3)) { observer.send(value: .failed(NSError())) }
            scheduler.schedule(after: .seconds(4)) { observer.send(value: .completed) }
            scheduler.schedule(after: .seconds(5)) { observer.send(value: .value("B")) }

        }

        afterEach {

            scheduler.advance()
            expect(observeValues) == 0

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 0

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 1

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 1

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 1

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == 2

        }


        describe("Signal") {
            describe("`values()`") {
                it("forwards only values") {

                    signal.values()
                        .observeValues { _ in observeValues += 1 }

                }
            }
        }

        describe("SignalProducer") {
            describe("`values()`") {
                it("forwards only values") {

                    signal.producer.values()
                        .startWithValues { _ in observeValues += 1 }

                }
            }
        }

    }
}
