//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Foundation
import MutaroClientModule

public struct MutaroModel {
    public let id: Int
    public let imageUrl: String
    public let title: String
    public let description: String

    public init(id: Int, imageUrl: String, title: String, description: String) {
        self.id = id
        self.imageUrl = imageUrl
        self.title = title
        self.description = description
    }

    public init(dto: MutaroDTO) {
        self.id = dto.id
        self.imageUrl = dto.imageUrl
        self.title = dto.title
        self.description = dto.description
    }
}

extension MutaroModel: Equatable {}
