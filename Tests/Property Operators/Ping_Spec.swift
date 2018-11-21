//
//  Ping_Spec.swift
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



class Ping_Spec: QuickSpec {
    override func spec() {

        var observeValues: Int!

        var scheduler: TestScheduler!

        beforeEach {

            observeValues = 0

            scheduler = TestScheduler()

        }

        afterEach {

            scheduler.run()
            expect(observeValues) == 3

        }


        describe("MutableProperty<()>") {
            describe("`ping()`") {
                it("pings") {

                    let property = MutableProperty<()>(())

                    property.signal.observeValues {
                        if $0 == () { observeValues += 1 }
                    }

                    scheduler.schedule {
                        property.ping()
                        property.ping()
                        property.ping()
                    }

                }
            }
        }

        describe("MutableProperty<()?>") {
            describe("`ping()`") {
                it("pings") {

                    let property = MutableProperty<()?>(nil)

                    property.signal.observeValues {
                        if let value = $0, value == () { observeValues += 1 }
                    }

                    scheduler.schedule {
                        property.ping()
                        property.ping()
                        property.ping()
                    }

                }
            }
        }

    }
}
