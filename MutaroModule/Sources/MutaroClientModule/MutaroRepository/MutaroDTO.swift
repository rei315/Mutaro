//
//  MutaroDTO.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Foundation

public struct MutaroDTO {
    public let id: Int
    public let imageUrl: String
    public let title: String
    public let description: String
}

extension MutaroDTO: Equatable {}
extension MutaroDTO: Sendable {}
