//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Foundation
import Repositories

public struct MutaroModel {
    public let uploadDate: String
    public let imageUrl: String
    public let title: String
    public let description: String

    public init(uploadDate: String, imageUrl: String, title: String, description: String) {
        self.uploadDate = uploadDate
        self.imageUrl = imageUrl
        self.title = title
        self.description = description
    }

    public init(dto: MutaroDTO) {
        uploadDate = dto.uploadDate
        imageUrl = dto.imageUrl
        title = dto.title
        description = dto.description
    }
}

extension MutaroModel: Equatable {}
