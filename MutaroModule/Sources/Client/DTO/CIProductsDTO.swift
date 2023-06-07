//
//  CIProductsDTO.swift
//
//
//  Created by minguk-kim on 2023/06/06.
//

import Core
import Foundation

public struct CIProductsDTO: Codable {
    public let links: CIProductsLinks?
    public let data: CIProductsData?

    public struct CIProductsData: Codable {
        public let id: String?
        public let relationships: CIProductsRelationships?
        public let links: CIProductsLinks?
        public let type: String?
        public let attributes: CIProductsAttributes?
    }

    public struct CIProductsAttributes: Codable {
        public let name, createdDate, productType: String?
    }

    public struct CIProductsLinks: Codable {
        public let linksSelf: String?

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
        }
    }

    public struct CIProductsRelationships: Codable {
        public let app, additionalRepositories, buildRuns, workflows: CIProductsLinksElement?
        public let primaryRepositories: CIProductsLinksElement?
    }

    public struct CIProductsLinksElement: Codable {
        public let links: CIProductsLinksDetails?
    }

    public struct CIProductsLinksDetails: Codable {
        public let related, linksSelf: String?

        enum CodingKeys: String, CodingKey {
            case related
            case linksSelf = "self"
        }
    }
}
