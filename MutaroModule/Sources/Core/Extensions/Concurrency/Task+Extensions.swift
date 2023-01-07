//
//  Task+Extensions.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Float) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
