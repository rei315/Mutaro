//
//  TaskCancellable.swift
//
//
//  Created by minguk-kim on 2023/06/04.
//

import Foundation

public protocol AnyCancellableTask {
    func cancel()
}

extension Task: AnyCancellableTask {}

public final class TaskCancellable {
    private var tasks: [any AnyCancellableTask] = []

    public init() {}

    public func add(task: any AnyCancellableTask) {
        tasks.append(task)
    }

    public func cancel() {
        tasks.forEach { $0.cancel() }
        tasks.removeAll()
    }

    deinit {
        cancel()
    }
}

public extension Task {
    func store(in bag: TaskCancellable) {
        bag.add(task: self)
    }
}
