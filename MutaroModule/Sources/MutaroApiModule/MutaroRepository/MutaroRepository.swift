//
//  MutaroRepository.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Foundation

public protocol MutaroRepository: AnyObject {
    func getMutaros() async throws -> [MutaroDTO]
}
