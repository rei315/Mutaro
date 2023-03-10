//
//  File.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import CoreLocation
import Foundation
import UIKit

public protocol Applicable {}
extension Applicable {
    @discardableResult
    public func apply(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }

    public func lets<R>(block: (Self) -> R) -> R {
        return block(self)
    }
}

extension NSObject: Applicable {}
extension Int: Applicable {}
extension Int64: Applicable {}
extension Double: Applicable {}
extension String: Applicable {}
extension CLLocationCoordinate2D: Applicable {}
extension Array: Applicable {}
extension Bool: Applicable {}
