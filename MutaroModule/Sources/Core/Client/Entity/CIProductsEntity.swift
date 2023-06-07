//
//  CIProductsEntity.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Foundation

public struct CIProductsEntity {
    public let links: CIProductsLinks?
    public let data: CIProductsData?

    public init(links: CIProductsLinks?, data: CIProductsData?) {
        self.links = links
        self.data = data
    }

    public struct CIProductsData {
        public let id: String?
        public let type: String?
        public let attributes: CIProductsAttributes?
        public let relationships: CIProductsRelationships?
        public let links: CIProductsLinks?

        public init(id: String?, type: String?, attributes: CIProductsAttributes?, relationships: CIProductsRelationships?, links: CIProductsLinks?) {
            self.id = id
            self.type = type
            self.attributes = attributes
            self.relationships = relationships
            self.links = links
        }
    }

    public struct CIProductsAttributes {
        public let name: String?
        public let createdDate: String?
        public let productType: String?

        public init(name: String?, createdDate: String?, productType: String?) {
            self.name = name
            self.createdDate = createdDate
            self.productType = productType
        }
    }

    public struct CIProductsRelationships {
        public let app, workflows, primaryRepositories, additionalRepositories, buildRuns: CIProductsLinksElement?

        public init(app: CIProductsLinksElement?, workflows: CIProductsLinksElement?, primaryRepositories: CIProductsLinksElement?, additionalRepositories: CIProductsLinksElement?, buildRuns: CIProductsLinksElement?) {
            self.app = app
            self.workflows = workflows
            self.primaryRepositories = primaryRepositories
            self.additionalRepositories = additionalRepositories
            self.buildRuns = buildRuns
        }
    }

    // MARK: - CIProductsLinksElement

    public struct CIProductsLinksElement {
        public let links: CIProductsLinksDetails?

        public init(links: CIProductsLinksDetails?) {
            self.links = links
        }
    }

    // MARK: - CIProductsLinksDetails

    public struct CIProductsLinksDetails {
        public let related, linksSelf: String?

        public init(related: String?, linksSelf: String?) {
            self.related = related
            self.linksSelf = linksSelf
        }
    }

    // MARK: - CIProductsLinks

    public struct CIProductsLinks {
        public let linksSelf: String?

        public init(linksSelf: String?) {
            self.linksSelf = linksSelf
        }
    }
}
