//
//  NSObject+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Foundation

public extension NSObject {
    static func simpleClassName() -> String {
        NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    static func simpleSwiftUIHostingClassName() -> String {
        "\(self)".components(separatedBy: "<").first ?? ""
    }
}
