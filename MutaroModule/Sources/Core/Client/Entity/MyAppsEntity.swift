//
//  MyAppsEntity.swift
//
//
//  Created by minguk-kim on 2023/05/21.
//

import Foundation

// MARK: - MyAppsEntity

public struct MyAppsEntity: Sendable {
    public let links: MyAppsLinks?
    public let data: [MyAppsData]?
    public let meta: MyAppsMeta?

    public init(links: MyAppsLinks?, data: [MyAppsData]?, meta: MyAppsMeta?) {
        self.links = links
        self.data = data
        self.meta = meta
    }

    // MARK: - MyAppsDatum

    public struct MyAppsData: Sendable {
        public let id: String?
        public let relationships: MyAppsRelationships?
        public let links: MyAppsLinks?
        public let type: String?
        public let attributes: MyAppsAttributes?

        public init(id: String?, relationships: MyAppsRelationships?, links: MyAppsLinks?, type: String?, attributes: MyAppsAttributes?) {
            self.id = id
            self.relationships = relationships
            self.links = links
            self.type = type
            self.attributes = attributes
        }
    }

    // MARK: - MyAppsAttributes

    public struct MyAppsAttributes: Sendable {
        public let subscriptionStatusURLVersionForSandbox, subscriptionStatusURLVersion: JSONNull?
        public let availableInNewTerritories: Bool?
        public let sku: String?
        public let contentRightsDeclaration: String?
        public let bundleID, primaryLocale: String?
        public let subscriptionStatusURL, subscriptionStatusURLForSandbox: JSONNull?
        public let name: String?
        public let isOrEverWasMadeForKids: Bool?

        public init(subscriptionStatusURLVersionForSandbox: JSONNull?, subscriptionStatusURLVersion: JSONNull?, availableInNewTerritories: Bool?, sku: String?, contentRightsDeclaration: String?, bundleID: String?, primaryLocale: String?, subscriptionStatusURL: JSONNull?, subscriptionStatusURLForSandbox: JSONNull?, name: String?, isOrEverWasMadeForKids: Bool?) {
            self.subscriptionStatusURLVersionForSandbox = subscriptionStatusURLVersionForSandbox
            self.subscriptionStatusURLVersion = subscriptionStatusURLVersion
            self.availableInNewTerritories = availableInNewTerritories
            self.sku = sku
            self.contentRightsDeclaration = contentRightsDeclaration
            self.bundleID = bundleID
            self.primaryLocale = primaryLocale
            self.subscriptionStatusURL = subscriptionStatusURL
            self.subscriptionStatusURLForSandbox = subscriptionStatusURLForSandbox
            self.name = name
            self.isOrEverWasMadeForKids = isOrEverWasMadeForKids
        }
    }

    // MARK: - MyAppsRelationships

    public struct MyAppsRelationships: Sendable {
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

        public init(reviewSubmissions: MyAppsLinksElement?, betaAppLocalizations: MyAppsLinksElement?, promotedPurchases: MyAppsLinksElement?, ciProduct: MyAppsLinksElement?, appClips: MyAppsLinksElement?, betaTesters: MyAppsBetaTesters?, inAppPurchases: MyAppsLinksElement?, appAvailability: MyAppsLinksElement?, preReleaseVersions: MyAppsLinksElement?, appPricePoints: MyAppsLinksElement?, betaAppReviewDetail: MyAppsLinksElement?, builds: MyAppsLinksElement?, availableTerritories: MyAppsLinksElement?, inAppPurchasesV2: MyAppsLinksElement?, customerReviews: MyAppsLinksElement?, betaGroups: MyAppsLinksElement?, betaLicenseAgreement: MyAppsLinksElement?, endUserLicenseAgreement: MyAppsLinksElement?, appPriceSchedule: MyAppsLinksElement?, subscriptionGroups: MyAppsLinksElement?, gameCenterEnabledVersions: MyAppsLinksElement?, perfPowerMetrics: MyAppsPerfPowerMetrics?, appEvents: MyAppsLinksElement?, subscriptionGracePeriod: MyAppsLinksElement?, pricePoints: MyAppsLinksElement?, appCustomProductPages: MyAppsLinksElement?, preOrder: MyAppsLinksElement?, appInfos: MyAppsLinksElement?, appStoreVersions: MyAppsLinksElement?, prices: MyAppsLinksElement?) {
            self.reviewSubmissions = reviewSubmissions
            self.betaAppLocalizations = betaAppLocalizations
            self.promotedPurchases = promotedPurchases
            self.ciProduct = ciProduct
            self.appClips = appClips
            self.betaTesters = betaTesters
            self.inAppPurchases = inAppPurchases
            self.appAvailability = appAvailability
            self.preReleaseVersions = preReleaseVersions
            self.appPricePoints = appPricePoints
            self.betaAppReviewDetail = betaAppReviewDetail
            self.builds = builds
            self.availableTerritories = availableTerritories
            self.inAppPurchasesV2 = inAppPurchasesV2
            self.customerReviews = customerReviews
            self.betaGroups = betaGroups
            self.betaLicenseAgreement = betaLicenseAgreement
            self.endUserLicenseAgreement = endUserLicenseAgreement
            self.appPriceSchedule = appPriceSchedule
            self.subscriptionGroups = subscriptionGroups
            self.gameCenterEnabledVersions = gameCenterEnabledVersions
            self.perfPowerMetrics = perfPowerMetrics
            self.appEvents = appEvents
            self.subscriptionGracePeriod = subscriptionGracePeriod
            self.pricePoints = pricePoints
            self.appCustomProductPages = appCustomProductPages
            self.preOrder = preOrder
            self.appInfos = appInfos
            self.appStoreVersions = appStoreVersions
            self.prices = prices
        }
    }

    // MARK: - MyAppsAppAvailability

    public struct MyAppsLinksElement: Sendable {
        public let links: MyAppsLinksDetails?

        public init(links: MyAppsLinksDetails?) {
            self.links = links
        }
    }

    // MARK: - MyAppsAppAvailabilityLinks

    public struct MyAppsLinksDetails: Sendable {
        public let related, linksSelf: String?

        public init(related: String?, linksSelf: String?) {
            self.related = related
            self.linksSelf = linksSelf
        }
    }

    // MARK: - MyAppsLinks

    public struct MyAppsLinks: Sendable {
        public let linksSelf: String?

        public init(linksSelf: String?) {
            self.linksSelf = linksSelf
        }
    }

    // MARK: - MyAppsBetaTesters

    public struct MyAppsBetaTesters: Sendable {
        public let links: MyAppsLinks?

        public init(links: MyAppsLinks?) {
            self.links = links
        }
    }

    // MARK: - MyAppsPerfPowerMetrics

    public struct MyAppsPerfPowerMetrics: Sendable {
        public let links: MyAppsPerfPowerMetricsLinks?

        public init(links: MyAppsPerfPowerMetricsLinks?) {
            self.links = links
        }
    }

    // MARK: - MyAppsPerfPowerMetricsLinks

    public struct MyAppsPerfPowerMetricsLinks: Sendable {
        public let related: String?

        public init(related: String?) {
            self.related = related
        }
    }

    // MARK: - MyAppsMeta

    public struct MyAppsMeta: Sendable {
        public let paging: MyAppsPaging?

        public init(paging: MyAppsPaging?) {
            self.paging = paging
        }
    }

    // MARK: - MyAppsPaging

    public struct MyAppsPaging: Sendable {
        public let total, limit: Int?

        public init(total: Int?, limit: Int?) {
            self.total = total
            self.limit = limit
        }
    }
}
