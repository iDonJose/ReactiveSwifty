//
//  Retry_Spec.swift
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



class Retry_Spec: QuickSpec {
    override func spec() {

        var producer: SignalProducer<Int, NSError>!
        var failCount: Int!
        var observeEvents: [String]!

        var scheduler: TestScheduler!

        beforeEach {

            failCount = 0

            producer = SignalProducer<Int, NSError> { observer, _ in

                scheduler.schedule(after: .seconds(0)) { observer.send(value: 1) }

                if failCount >= 2 {
                    scheduler.schedule(after: .seconds(1)) { observer.send(value: 2) }
                }
                else {

                    failCount += 1

                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    scheduler.schedule(after: .seconds(1)) { observer.send(error: error) }
                }

            }

            observeEvents = []

            scheduler = TestScheduler()

        }


        describe("SignalProducer") {

            describe("`retry(every:on:)`") {
                it("retries on failure") {

                    producer.retry(every: 1,
                                   on: scheduler)
                        .startWithResult { result in
                            switch result {
                            case let .success(value): observeEvents.append("V\(value)")
                            case .failure: observeEvents.append("F")
                            }
                        }

                    scheduler.run()

                    expect(observeEvents) == ["V1", "V1", "V1", "V2"]

                }
            }

        }

    }
}
