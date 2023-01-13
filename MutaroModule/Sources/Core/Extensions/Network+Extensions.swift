//
//  Network+Extensions.swift
//  
//
//  Created by minguk-kim on 2023/01/14.
//

import Network

extension NWPathMonitor {
    public func isOnline() async -> Bool {
        return await withCheckedContinuation { continuation in
            pathUpdateHandler = { [weak self] path in
                continuation.resume(returning: path.status == .satisfied)
                self?.cancel()
            }
            start(queue: .global(qos: .background))
        }
    }
}
