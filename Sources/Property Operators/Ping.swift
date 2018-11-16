//
//  Ping.swift
//  ReactiveSwifty
//
//  Created by José Donor on 11/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



extension MutableProperty where Value == () {

    /// Pings.
    public func ping() {
        swap(())
    }

}

extension MutableProperty where Value == Optional<()> {

    /// Pings.
    public func ping() {
        swap(())
    }

}
