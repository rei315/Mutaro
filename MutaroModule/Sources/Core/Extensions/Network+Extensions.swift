//
//  Network+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/14.
//

import Network

public extension NWPathMonitor {
    func isOnline() async -> Bool {
        await withCheckedContinuation { continuation in
            pathUpdateHandler = { [weak self] path in
                continuation.resume(returning: path.status == .satisfied)
                self?.cancel()
            }
            start(queue: .global(qos: .background))
        }
    }
}
