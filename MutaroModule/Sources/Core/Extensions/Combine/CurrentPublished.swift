//
//  CurrentPublished.swift
//
//
//  Created by minguk-kim on 2023/06/04.
//

import Combine

@propertyWrapper
public class currentPublished<Value> {
    private var subject: CurrentValueSubject<Value, Never>

    public init(wrappedValue: Value) {
        subject = CurrentValueSubject(wrappedValue)
    }

    public var wrappedValue: Value {
        get { subject.value }
        set { subject.send(newValue) }
    }

    public var projectedValue: CurrentValueSubject<Value, Never> {
        subject
    }

    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
}
