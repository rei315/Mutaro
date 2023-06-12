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
    
    func asyncSink(
        taskCancellable: TaskCancellable,
        receiveCompletion: @escaping (Subscribers.Completion<Failure>) -> Void,
        receiveValue: @escaping (Output) async -> Void
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Output, Failure>()
        let cancellable = self.subscribe(subject)
        
        return subject.sink(
            receiveCompletion: { completion in
                receiveCompletion(completion)
                cancellable.cancel()
            },
            receiveValue: { value in
                Task {
                    await receiveValue(value)
                }
                .store(in: taskCancellable)
            }
        )
    }
    
    func asyncSink(
        taskCancellable: TaskCancellable,
        receiveValue: @escaping (Output) async -> Void
    ) -> AnyCancellable {
        let subject = PassthroughSubject<Output, Never>()
        
        return subject.sink(
            receiveValue: { value in
                Task {
                    await receiveValue(value)
                }
                .store(in: taskCancellable)
            }
        )
    }
}
