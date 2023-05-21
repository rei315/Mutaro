//
//  BuildsEntity.swift
//
//
//  Created by minguk-kim on 2023/05/21.
//

import Foundation

// MARK: - BuildsEntity

public struct BuildsEntity {
    public let links: BuildsLinks?
    public let data: [BuildsDatum]?
    public let meta: BuildsMeta?

    public init(links: BuildsLinks?, data: [BuildsDatum]?, meta: BuildsMeta?) {
        self.links = links
        self.data = data
        self.meta = meta
    }

    // MARK: - BuildsDatum

    public struct BuildsDatum {
        public let id: String?
        public let relationships: BuildsRelationships?
        public let links: BuildsLinks?
        public let type: String?
        public let attributes: BuildsAttributes?

        public init(id: String?, relationships: BuildsRelationships?, links: BuildsLinks?, type: String?, attributes: BuildsAttributes?) {
            self.id = id
            self.relationships = relationships
            self.links = links
            self.type = type
            self.attributes = attributes
        }
    }

    // MARK: - BuildsAttributes

    public struct BuildsAttributes {
        public let expirationDate: Date?
        public let expired: Bool?
        public let processingState, buildAudienceType, minOSVersion: String?
        public let iconAssetToken: BuildsIconAssetToken?
        public let version: String?
        public let uploadedDate: Date?
        public let lsMinimumSystemVersion: JSONNull?
        public let computedMinMACOSVersion: String?
        public let usesNonExemptEncryption: Bool?

        public init(expirationDate: Date?, expired: Bool?, processingState: String?, buildAudienceType: String?, minOSVersion: String?, iconAssetToken: BuildsIconAssetToken?, version: String?, uploadedDate: Date?, lsMinimumSystemVersion: JSONNull?, computedMinMACOSVersion: String?, usesNonExemptEncryption: Bool?) {
            self.expirationDate = expirationDate
            self.expired = expired
            self.processingState = processingState
            self.buildAudienceType = buildAudienceType
            self.minOSVersion = minOSVersion
            self.iconAssetToken = iconAssetToken
            self.version = version
            self.uploadedDate = uploadedDate
            self.lsMinimumSystemVersion = lsMinimumSystemVersion
            self.computedMinMACOSVersion = computedMinMACOSVersion
            self.usesNonExemptEncryption = usesNonExemptEncryption
        }
    }

    // MARK: - BuildsIconAssetToken

    public struct BuildsIconAssetToken {
        public let width: Int?
        public let templateURL: String?
        public let height: Int?

        public init(width: Int?, templateURL: String?, height: Int?) {
            self.width = width
            self.templateURL = templateURL
            self.height = height
        }
    }

    // MARK: - BuildsLinks

    public struct BuildsLinks {
        public let linksSelf: String?

        public init(linksSelf: String?) {
            self.linksSelf = linksSelf
        }
    }

    // MARK: - BuildsRelationships

    public struct BuildsRelationships {
        public let betaAppReviewSubmission, appStoreVersion, appEncryptionDeclaration, individualTesters: BuildsLinksElement?
        public let perfPowerMetrics: BuildsPerfPowerMetrics?
        public let betaBuildLocalizations: BuildsLinksElement?
        public let betaGroups: BuildsBetaGroups?
        public let app, diagnosticSignatures, preReleaseVersion, buildBetaDetail: BuildsLinksElement?
        public let icons: BuildsLinksElement?

        public init(betaAppReviewSubmission: BuildsLinksElement?, appStoreVersion: BuildsLinksElement?, appEncryptionDeclaration: BuildsLinksElement?, individualTesters: BuildsLinksElement?, perfPowerMetrics: BuildsPerfPowerMetrics?, betaBuildLocalizations: BuildsLinksElement?, betaGroups: BuildsBetaGroups?, app: BuildsLinksElement?, diagnosticSignatures: BuildsLinksElement?, preReleaseVersion: BuildsLinksElement?, buildBetaDetail: BuildsLinksElement?, icons: BuildsLinksElement?) {
            self.betaAppReviewSubmission = betaAppReviewSubmission
            self.appStoreVersion = appStoreVersion
            self.appEncryptionDeclaration = appEncryptionDeclaration
            self.individualTesters = individualTesters
            self.perfPowerMetrics = perfPowerMetrics
            self.betaBuildLocalizations = betaBuildLocalizations
            self.betaGroups = betaGroups
            self.app = app
            self.diagnosticSignatures = diagnosticSignatures
            self.preReleaseVersion = preReleaseVersion
            self.buildBetaDetail = buildBetaDetail
            self.icons = icons
        }
    }

    // MARK: - BuildsLinksElement

    public struct BuildsLinksElement {
        public let links: BuildsLinksDetails?

        public init(links: BuildsLinksDetails?) {
            self.links = links
        }
    }

    // MARK: - BuildsLinksDetails

    public struct BuildsLinksDetails {
        public let related, linksSelf: String?

        public init(related: String?, linksSelf: String?) {
            self.related = related
            self.linksSelf = linksSelf
        }
    }

    // MARK: - BuildsBetaGroups

    public struct BuildsBetaGroups {
        public let links: BuildsLinks?

        public init(links: BuildsLinks?) {
            self.links = links
        }
    }

    // MARK: - BuildsPerfPowerMetrics

    public struct BuildsPerfPowerMetrics {
        public let links: BuildsPerfPowerMetricsLinks?

        public init(links: BuildsPerfPowerMetricsLinks?) {
            self.links = links
        }
    }

    // MARK: - BuildsPerfPowerMetricsLinks

    public struct BuildsPerfPowerMetricsLinks {
        public let related: String?

        public init(related: String?) {
            self.related = related
        }
    }

    // MARK: - BuildsMeta

    public struct BuildsMeta {
        public let paging: BuildsPaging?

        public init(paging: BuildsPaging?) {
            self.paging = paging
        }
    }

    // MARK: - BuildsPaging

    public struct BuildsPaging {
        public let total, limit: Int?

        public init(total: Int?, limit: Int?) {
            self.total = total
            self.limit = limit
        }
    }
}
