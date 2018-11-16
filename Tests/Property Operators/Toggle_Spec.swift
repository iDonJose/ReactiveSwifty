//
//  Toggle_Spec.swift
//  ReactiveSwifty-iOS
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import Nimble
import Quick
import ReactiveSwift
@testable import ReactiveSwifty_iOS
import Result



class Toggle_Spec: QuickSpec {
    override func spec() {

        var observeValues: [Bool]!

        var scheduler: TestScheduler!

        beforeEach {

            observeValues = []

            scheduler = TestScheduler()

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == [true, false, true]

        }


        describe("MutableProperty<Bool>") {
            describe("`toggle()`") {
                it("toggles value") {

                    let property = MutableProperty<Bool>(false)

                    property.signal.observeValues { observeValues.append($0) }

                    scheduler.schedule {
                        property.toggle()
                        property.toggle()
                        property.toggle()
                    }

                }
            }
        }

        describe("MutableProperty<Bool?>") {
            describe("`toggle()`") {
                it("toggles value") {

                    let property = MutableProperty<Bool?>(nil)

                    property.signal.observeValues {
                        if let value = $0 { observeValues.append(value) }
                    }

                    scheduler.schedule {
                        property.toggle()
                        property.toggle()
                        property.toggle()
                    }

                }
            }
        }

    }
}
