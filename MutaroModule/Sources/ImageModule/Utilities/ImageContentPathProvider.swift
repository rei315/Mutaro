//
//  ImageContentPathProvider.swift
//
//
//  Created by minguk-kim on 2023/01/02.
//

import Foundation

public struct ImageContentPathProvider {
    public enum ContentFileType: Int, CaseIterable {
        case mutaro0
        case mutaro1
        case mutaro2
        case mutaro3
        case mutaro4
        case mutaro5
        case mutaro6

        var resourcePath: String {
            switch self {
            case .mutaro0:
                return "mutaro_0"
            case .mutaro1:
                return "mutaro_1"
            case .mutaro2:
                return "mutaro_2"
            case .mutaro3:
                return "mutaro_3"
            case .mutaro4:
                return "mutaro_4"
            case .mutaro5:
                return "mutaro_5"
            case .mutaro6:
                return "mutaro_6"
            }
        }
    }

    static let contentType = "png"

    static func path(type: ContentFileType) -> String? {
        Bundle.main.path(forResource: type.resourcePath, ofType: contentType)
    }

    static func url(type: ContentFileType) -> URL? {
        Bundle.main.url(forResource: type.resourcePath, withExtension: contentType)
    }
}
