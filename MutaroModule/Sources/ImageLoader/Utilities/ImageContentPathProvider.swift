//
//  ImageContentPathProvider.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import Foundation

public protocol ContentFileType {
    var resourcePath: String { get }
    var title: String { get }
    var description: String { get }
}

public struct ImageContentPathProvider {
    static let contentType = "png"

    static func path(type: ContentFileType) -> String? {
        Bundle.main.path(forResource: type.resourcePath, ofType: contentType)
    }

    static func url(type: ContentFileType) -> URL? {
        Bundle.main.url(forResource: type.resourcePath, withExtension: contentType)
    }
}
