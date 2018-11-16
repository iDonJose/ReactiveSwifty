//
//  Binding_Spec.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import Nimble
import Quick
import ReactiveSwift
@testable import ReactiveSwifty_iOS
import Result



class Binding_Spec: QuickSpec {
    override func spec() {

        var signal_1: Signal<String, NoError>!
        var observer_1, observer_2: Signal<String, NoError>.Observer!
        var observeValues: [String]!

        var scheduler: TestScheduler!

        beforeEach {

            let (signal, observer) = Signal<String, NoError>.pipe()
            signal_1 = signal
            observer_1 = observer

            observer_2 = Signal<String, NoError>.Observer(value: { observeValues.append($0) })

            observeValues = []

            scheduler = TestScheduler()

            scheduler.schedule {
                observer_1.send(value: "A")
                observer_1.send(value: "B")
                observer_1.send(value: "C")
            }

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == ["A", "B", "C"]

        }


        describe("Binding") {
            describe("`<~`") {

                context("from a Signal to an Observer") {
                    it("binds") {

                        observer_2 <~ signal_1

                    }
                }

                context("from a SignalProducer to an Observer") {
                    it("binds") {

                        observer_2 <~ signal_1.producer

                    }
                }

            }
        }

    }
}
