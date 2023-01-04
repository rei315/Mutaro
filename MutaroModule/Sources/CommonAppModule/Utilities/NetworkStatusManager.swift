//
//  NetworkStatusManager.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Foundation
import Network

public protocol NetworkStatusManagerProtocol {
    var isOnline: Bool { get async }
}

@globalActor
public final actor NetworkStatusManager: NetworkStatusManagerProtocol {
    public static let shared = NetworkStatusManager()
    private let monitor = NWPathMonitor()

    public var isOnline: Bool {
        get async {
            await withCheckedContinuation { continuation in
                monitor.pathUpdateHandler = { path in
                    continuation.resume(returning: path.status == .satisfied)
                }
            }
        }
    }

    public init() {
        monitor.start(queue: .global(qos: .background))
    }
}
