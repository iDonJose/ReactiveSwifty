//
//  SpaceOut_Spec.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import Nimble
import Quick
import ReactiveSwift
@testable import ReactiveSwifty
import Result



class SpaceOut_Spec: QuickSpec {
    override func spec() {

        var signal: Signal<Int, NoError>!
        var observer: Signal<Int, NoError>.Observer!
        var observeValues: [Int]!

        var scheduler: TestScheduler!

        beforeEach {

            let (_signal, _observer) = Signal<Int, NoError>.pipe()
            signal = _signal
            observer = _observer

            observeValues = []

            scheduler = TestScheduler()

            scheduler.schedule {
                observer.send(value: 1)
                observer.send(value: 2)
                observer.send(value: 3)
            }

        }

        afterEach {

            scheduler.advance()
            expect(observeValues) == [1]

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == [1, 2]

            scheduler.advance(by: .seconds(1))
            expect(observeValues) == [1, 2, 3]

        }


        describe("Signal") {
            describe("`spaceOut(by:on:)`") {
                it("spaces out values by a given interval") {

                    signal.spaceOut(by: 1, on: scheduler)
                        .observeValues { observeValues.append($0) }

                }
            }
        }

        describe("SignalProducer") {
            describe("`spaceOut(by:on:)`") {
                it("spaces out values by a given interval") {

                    signal.producer.spaceOut(by: 1, on: scheduler)
                        .startWithValues { observeValues.append($0) }

                }
            }
        }

    }
}
