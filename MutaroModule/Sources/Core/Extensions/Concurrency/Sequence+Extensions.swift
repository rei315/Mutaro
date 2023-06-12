//
//  Sequence+Extensions.swift
//
//
//  Created by minguk-kim on 2023/06/13.
//

import Combine

public extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }

    func concurrentMap<T>(
        _ transform: @escaping (Element) async -> T
    ) async throws -> [T] {
        try await withThrowingTaskGroup(of: T.self) { group -> [T] in
            for element in self {
                group.addTask {
                    await transform(element)
                }
            }
            var results = [T]()
            for try await result in group {
                results.append(result)
            }
            return results
        }
    }

    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }

    func concurrentForEach(
        _ operation: @escaping (Element) async -> Void
    ) async {
        await withTaskGroup(of: Void.self) { group in
            for element in self {
                group.addTask {
                    await operation(element)
                }
            }
        }
    }
}
