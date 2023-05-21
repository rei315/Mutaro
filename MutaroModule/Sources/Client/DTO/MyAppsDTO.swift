//
//  MyAppsDTO.swift
//
//
//  Created by minguk-kim on 2023/05/04.
//

import Core
import Foundation

// MARK: - MyAppsDTO

public struct MyAppsDTO: Codable {
    public let links: MyAppsLinks?
    public let data: [MyAppsData]?
    public let meta: MyAppsMeta?

    // MARK: - MyAppsDatum

    public struct MyAppsData: Codable {
        public let id: String?
        public let relationships: MyAppsRelationships?
        public let links: MyAppsLinks?
        public let type: String?
        public let attributes: MyAppsAttributes?
    }

    // MARK: - MyAppsAttributes

    public struct MyAppsAttributes: Codable {
        public let subscriptionStatusURLVersionForSandbox, subscriptionStatusURLVersion: JSONNull?
        public let availableInNewTerritories: Bool?
        public let sku: String?
        public let contentRightsDeclaration: String?
        public let bundleID, primaryLocale: String?
        public let subscriptionStatusURL, subscriptionStatusURLForSandbox: JSONNull?
        public let name: String?
        public let isOrEverWasMadeForKids: Bool?

        enum CodingKeys: String, CodingKey {
            case subscriptionStatusURLVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
            case subscriptionStatusURLVersion = "subscriptionStatusUrlVersion"
            case availableInNewTerritories, sku, contentRightsDeclaration
            case bundleID = "bundleId"
            case primaryLocale
            case subscriptionStatusURL = "subscriptionStatusUrl"
            case subscriptionStatusURLForSandbox = "subscriptionStatusUrlForSandbox"
            case name, isOrEverWasMadeForKids
        }
    }

    // MARK: - MyAppsRelationships

    public struct MyAppsRelationships: Codable {
        public let reviewSubmissions, betaAppLocalizations, promotedPurchases, ciProduct: MyAppsLinksElement?
        public let appClips: MyAppsLinksElement?
        public let betaTesters: MyAppsBetaTesters?
        public let inAppPurchases, appAvailability, preReleaseVersions, appPricePoints: MyAppsLinksElement?
        public let betaAppReviewDetail, builds, availableTerritories, inAppPurchasesV2: MyAppsLinksElement?
        public let customerReviews, betaGroups, betaLicenseAgreement, endUserLicenseAgreement: MyAppsLinksElement?
        public let appPriceSchedule, subscriptionGroups, gameCenterEnabledVersions: MyAppsLinksElement?
        public let perfPowerMetrics: MyAppsPerfPowerMetrics?
        public let appEvents, subscriptionGracePeriod, pricePoints, appCustomProductPages: MyAppsLinksElement?
        public let preOrder, appInfos, appStoreVersions, prices: MyAppsLinksElement?
    }

    // MARK: - MyAppsAppAvailability

    public struct MyAppsLinksElement: Codable {
        public let links: MyAppsLinksDetails?
    }

    // MARK: - MyAppsAppAvailabilityLinks

    public struct MyAppsLinksDetails: Codable {
        public let related, linksSelf: String?

        enum CodingKeys: String, CodingKey {
            case related
            case linksSelf = "self"
        }
    }

    // MARK: - MyAppsLinks

    public struct MyAppsLinks: Codable {
        public let linksSelf: String?

        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
        }

        public init(linksSelf: String?) {
            self.linksSelf = linksSelf
        }
    }

    // MARK: - MyAppsBetaTesters

    public struct MyAppsBetaTesters: Codable {
        public let links: MyAppsLinks?
    }

    // MARK: - MyAppsPerfPowerMetrics

    public struct MyAppsPerfPowerMetrics: Codable {
        public let links: MyAppsPerfPowerMetricsLinks?
    }

    // MARK: - MyAppsPerfPowerMetricsLinks

    public struct MyAppsPerfPowerMetricsLinks: Codable {
        public let related: String?
    }

    // MARK: - MyAppsMeta

    public struct MyAppsMeta: Codable {
        public let paging: MyAppsPaging?
    }

    // MARK: - MyAppsPaging

    public struct MyAppsPaging: Codable {
        public let total, limit: Int?
    }
}
