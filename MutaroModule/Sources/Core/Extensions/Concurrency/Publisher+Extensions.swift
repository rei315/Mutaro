//
//  Publisher+Extensions.swift
//
//
//  Created by minguk-kim on 2023/06/12.
//

import Combine

public extension Publisher {
    func asyncMap<T>(
        _ transform: @escaping (Output) async -> T
    ) -> Publishers.FlatMap<Future<T, Never>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    let output = await transform(value)
                    promise(.success(output))
                }
            }
        }
    }

    func asyncMapThrows<T>(
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Publishers.SetFailureType<Self, Error>> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
    }
}

public extension Publisher where Self.Failure == Never {
    func asyncSink(
        taskCancellable: TaskCancellable,
        receiveValue: @escaping ((Self.Output) async -> Void)
    ) -> AnyCancellable {
        sink { value in
            Task {
                await receiveValue(value)
            }
            .store(in: taskCancellable)
        }
    }
}
