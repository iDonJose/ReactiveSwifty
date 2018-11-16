//
//  Toggle.swift
//  ReactiveSwifty
//
//  Created by José Donor on 10/11/2018.
//  Copyright © 2018 iDonJose. All rights reserved.
//

import ReactiveSwift
import Result



extension MutableProperty where Value == Bool {

    /// Toggles value.
    ///
    /// - Returns: The previous value.
    @discardableResult
    public func toggle() -> Bool {

        return modify {
            let oldValue = $0
            $0 = !$0
            return oldValue
        }

    }

}

extension MutableProperty where Value == Optional<Bool> {

    /// Toggles value.
    ///
    /// - Returns: The previous value.
    @discardableResult
    public func toggle() -> Bool {

        return modify {
            let oldValue = $0 ?? false
            $0 = !oldValue
            return oldValue
        }

    }

}
