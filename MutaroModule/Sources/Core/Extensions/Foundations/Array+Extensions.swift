//
//  Array+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/06.
//

import Foundation

public extension Array {
    subscript(getOrNil index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    subscript(getOrNil bounds: Indices) -> SubSequence? {
        guard let firstIndex: Int = bounds.first,
              let lastIndex: Int = bounds.last,
              let _: Element = self[getOrNil: firstIndex],
              let _: Element = self[getOrNil: lastIndex]
        else {
            return nil
        }
        return self[bounds]
    }
}
