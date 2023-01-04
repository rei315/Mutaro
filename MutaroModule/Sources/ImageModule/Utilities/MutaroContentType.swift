//
//  File.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Foundation

public enum MutaroContentType: Int, CaseIterable, ContentFileType {
    case mutaro0
    case mutaro1
    case mutaro2
    case mutaro3
    case mutaro4
    case mutaro5
    case mutaro6

    public var allCases: Int {
        self.allCases
    }

    public var resourcePath: String {
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

    public var title: String {
        switch self {
        case .mutaro0:
            return "mutaro 0番"
        case .mutaro1:
            return "mutaro 1番"
        case .mutaro2:
            return "mutaro 2番"
        case .mutaro3:
            return "mutaro 3番"
        case .mutaro4:
            return "mutaro 4番"
        case .mutaro5:
            return "mutaro 5番"
        case .mutaro6:
            return "mutaro 6番"
        }
    }

    public var description: String {
        switch self {
        case .mutaro0:
            return "mutaroがごろごろ　0番"
        case .mutaro1:
            return "mutaroがごろごろ 1番"
        case .mutaro2:
            return "mutaroがごろごろ 2番"
        case .mutaro3:
            return "mutaroがごろごろ 3番"
        case .mutaro4:
            return "mutaroがごろごろ 4番"
        case .mutaro5:
            return "mutaroがごろごろ 5番"
        case .mutaro6:
            return "mutaro 6番"
        }
    }
}
