//
//  NSObject+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Foundation

extension NSObject {
    public static func simpleClassName() -> String {
        NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    public static func simpleSwiftUIHostingClassName() -> String {
        "\(self)".components(separatedBy: "<").first ?? ""
    }
}
