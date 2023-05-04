//
//  BuildsElement.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Foundation

// MARK: - BuildsElement

public struct BuildsElement: Codable {
    public let links: BuildsLinks?
    public let data: [BuildsDatum]?
    public let meta: BuildsMeta?

    // MARK: - BuildsDatum

    public struct BuildsDatum: Codable {
        public let id: String?
        public let relationships: BuildsRelationships?
        public let links: BuildsLinks?
        public let type: String?
        public let attributes: BuildsAttributes?
    }

    // MARK: - BuildsAttributes

    public struct BuildsAttributes: Codable {
        public let expirationDate: Date?
        public let expired: Bool?
        public let processingState, buildAudienceType, minOSVersion: String?
        public let iconAssetToken: BuildsIconAssetToken?
        public let version: String?
        public let uploadedDate: Date?
        public let lsMinimumSystemVersion: JSONNull?
        public let computedMinMACOSVersion: String?
        public let usesNonExemptEncryption: Bool?

        enum CodingKeys: String, CodingKey {
            case expirationDate, expired, processingState, buildAudienceType
            case minOSVersion = "minOsVersion"
            case iconAssetToken, version, uploadedDate, lsMinimumSystemVersion
            case computedMinMACOSVersion = "computedMinMacOsVersion"
            case usesNonExemptEncryption
        }

        public init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<BuildsElement.BuildsAttributes.CodingKeys> = try decoder.container(keyedBy: BuildsElement.BuildsAttributes.CodingKeys.self)
            if let expirationDateString = try container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.expirationDate),
               let expirationDate = DateFormatter.iso8601Full.date(from: expirationDateString) {
                self.expirationDate = expirationDate
            } else {
                expirationDate = nil
            }

            expired = try container.decodeIfPresent(Bool.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.expired)
            processingState = try container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.processingState)
            buildAudienceType = try container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.buildAudienceType)
            minOSVersion = try container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.minOSVersion)
            iconAssetToken = try container.decodeIfPresent(BuildsElement.BuildsIconAssetToken.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.iconAssetToken)
            version = try container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.version)
            if let uploadedDateString = try? container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.uploadedDate),
               let uploadedDate = DateFormatter.iso8601Full.date(from: uploadedDateString) {
                self.uploadedDate = uploadedDate
            } else {
                uploadedDate = nil
            }

            lsMinimumSystemVersion = try container.decodeIfPresent(JSONNull.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.lsMinimumSystemVersion)
            computedMinMACOSVersion = try container.decodeIfPresent(String.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.computedMinMACOSVersion)
            usesNonExemptEncryption = try container.decodeIfPresent(Bool.self, forKey: BuildsElement.BuildsAttributes.CodingKeys.usesNonExemptEncryption)
        }
    }

    // MARK: - BuildsIconAssetToken

    public struct BuildsIconAssetToken: Codable {
        public let width: Int?
        public let templateURL: String?
        public let height: Int?

        enum CodingKeys: String, CodingKey {
            case width
            case templateURL = "templateUrl"
            case height
        }
    }

    // MARK: - BuildsLinks

    public struct BuildsLinks: Codable {
        public let linksSelf: String?

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
        }
    }

    // MARK: - BuildsRelationships

    public struct BuildsRelationships: Codable {
        public let betaAppReviewSubmission, appStoreVersion, appEncryptionDeclaration, individualTesters: BuildsLinksElement?
        public let perfPowerMetrics: BuildsPerfPowerMetrics?
        public let betaBuildLocalizations: BuildsLinksElement?
        public let betaGroups: BuildsBetaGroups?
        public let app, diagnosticSignatures, preReleaseVersion, buildBetaDetail: BuildsLinksElement?
        public let icons: BuildsLinksElement?
    }

    // MARK: - BuildsLinksElement

    public struct BuildsLinksElement: Codable {
        public let links: BuildsLinksDetails?
    }

    // MARK: - BuildsLinksDetails

    public struct BuildsLinksDetails: Codable {
        public let related, linksSelf: String?

        enum CodingKeys: String, CodingKey {
            case related
            case linksSelf = "self"
        }
    }

    // MARK: - BuildsBetaGroups

    public struct BuildsBetaGroups: Codable {
        public let links: BuildsLinks?
    }

    // MARK: - BuildsPerfPowerMetrics

    public struct BuildsPerfPowerMetrics: Codable {
        public let links: BuildsPerfPowerMetricsLinks?
    }

    // MARK: - BuildsPerfPowerMetricsLinks

    public struct BuildsPerfPowerMetricsLinks: Codable {
        public let related: String?
    }

    // MARK: - BuildsMeta

    public struct BuildsMeta: Codable {
        public let paging: BuildsPaging?
    }

    // MARK: - BuildsPaging

    public struct BuildsPaging: Codable {
        public let total, limit: Int?
    }
}
