
import Foundation

public struct RelationshipsElement: Codable {
    public let reviewSubmissions: ReviewSubmissionsElement?
    public let betaAppLocalizations: BetaAppLocalizationsElement?
    public let promotedPurchases: PromotedPurchasesElement?
    public let ciProduct: CiProductElement?
    public let appClips: AppClipsElement?
    public let betaTesters: BetaTestersElement?
    public let inAppPurchases: InAppPurchasesElement?
    public let appAvailability: AppAvailabilityElement?
    public let preReleaseVersions: PreReleaseVersionsElement?
    public let appPricePoints: AppPricePointsElement?
    public let betaAppReviewDetail: BetaAppReviewDetailElement?
    public let builds: BuildsElement?
    public let availableTerritories: AvailableTerritoriesElement?
    public let inAppPurchasesV2: InAppPurchasesV2Element?
    public let customerReviews: CustomerReviewsElement?
    public let betaGroups: BetaGroupsElement?
    public let betaLicenseAgreement: BetaLicenseAgreementElement?
    public let endUserLicenseAgreement: EndUserLicenseAgreementElement?
    public let appPriceSchedule: AppPriceScheduleElement?
    public let subscriptionGroups: SubscriptionGroupsElement?
    public let gameCenterEnabledVersions: GameCenterEnabledVersionsElement?
    public let perfPowerMetrics: PerfPowerMetricsElement?
    public let appEvents: AppEventsElement?
    public let subscriptionGracePeriod: SubscriptionGracePeriodElement?
    public let pricePoints: PricePointsElement?
    public let appCustomProductPages: AppCustomProductPagesElement?
    public let preOrder: PreOrderElement?
    public let appInfos: AppInfosElement?
    public let appStoreVersions: AppStoreVersionsElement?
    public let prices: PricesElement?

    enum CodingKeys: String, CodingKey {
        case reviewSubmissions = "reviewSubmissions"
        case betaAppLocalizations = "betaAppLocalizations"
        case promotedPurchases = "promotedPurchases"
        case ciProduct = "ciProduct"
        case appClips = "appClips"
        case betaTesters = "betaTesters"
        case inAppPurchases = "inAppPurchases"
        case appAvailability = "appAvailability"
        case preReleaseVersions = "preReleaseVersions"
        case appPricePoints = "appPricePoints"
        case betaAppReviewDetail = "betaAppReviewDetail"
        case builds = "builds"
        case availableTerritories = "availableTerritories"
        case inAppPurchasesV2 = "inAppPurchasesV2"
        case customerReviews = "customerReviews"
        case betaGroups = "betaGroups"
        case betaLicenseAgreement = "betaLicenseAgreement"
        case endUserLicenseAgreement = "endUserLicenseAgreement"
        case appPriceSchedule = "appPriceSchedule"
        case subscriptionGroups = "subscriptionGroups"
        case gameCenterEnabledVersions = "gameCenterEnabledVersions"
        case perfPowerMetrics = "perfPowerMetrics"
        case appEvents = "appEvents"
        case subscriptionGracePeriod = "subscriptionGracePeriod"
        case pricePoints = "pricePoints"
        case appCustomProductPages = "appCustomProductPages"
        case preOrder = "preOrder"
        case appInfos = "appInfos"
        case appStoreVersions = "appStoreVersions"
        case prices = "prices"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        reviewSubmissions = try values.decodeIfPresent(ReviewSubmissionsElement.self, forKey: .reviewSubmissions)
        betaAppLocalizations = try values.decodeIfPresent(BetaAppLocalizationsElement.self, forKey: .betaAppLocalizations)
        promotedPurchases = try values.decodeIfPresent(PromotedPurchasesElement.self, forKey: .promotedPurchases)
        ciProduct = try values.decodeIfPresent(CiProductElement.self, forKey: .ciProduct)
        appClips = try values.decodeIfPresent(AppClipsElement.self, forKey: .appClips)
        betaTesters = try values.decodeIfPresent(BetaTestersElement.self, forKey: .betaTesters)
        inAppPurchases = try values.decodeIfPresent(InAppPurchasesElement.self, forKey: .inAppPurchases)
        appAvailability = try values.decodeIfPresent(AppAvailabilityElement.self, forKey: .appAvailability)
        preReleaseVersions = try values.decodeIfPresent(PreReleaseVersionsElement.self, forKey: .preReleaseVersions)
        appPricePoints = try values.decodeIfPresent(AppPricePointsElement.self, forKey: .appPricePoints)
        betaAppReviewDetail = try values.decodeIfPresent(BetaAppReviewDetailElement.self, forKey: .betaAppReviewDetail)
        builds = try values.decodeIfPresent(BuildsElement.self, forKey: .builds)
        availableTerritories = try values.decodeIfPresent(AvailableTerritoriesElement.self, forKey: .availableTerritories)
        inAppPurchasesV2 = try values.decodeIfPresent(InAppPurchasesV2Element.self, forKey: .inAppPurchasesV2)
        customerReviews = try values.decodeIfPresent(CustomerReviewsElement.self, forKey: .customerReviews)
        betaGroups = try values.decodeIfPresent(BetaGroupsElement.self, forKey: .betaGroups)
        betaLicenseAgreement = try values.decodeIfPresent(BetaLicenseAgreementElement.self, forKey: .betaLicenseAgreement)
        endUserLicenseAgreement = try values.decodeIfPresent(EndUserLicenseAgreementElement.self, forKey: .endUserLicenseAgreement)
        appPriceSchedule = try values.decodeIfPresent(AppPriceScheduleElement.self, forKey: .appPriceSchedule)
        subscriptionGroups = try values.decodeIfPresent(SubscriptionGroupsElement.self, forKey: .subscriptionGroups)
        gameCenterEnabledVersions = try values.decodeIfPresent(GameCenterEnabledVersionsElement.self, forKey: .gameCenterEnabledVersions)
        perfPowerMetrics = try values.decodeIfPresent(PerfPowerMetricsElement.self, forKey: .perfPowerMetrics)
        appEvents = try values.decodeIfPresent(AppEventsElement.self, forKey: .appEvents)
        subscriptionGracePeriod = try values.decodeIfPresent(SubscriptionGracePeriodElement.self, forKey: .subscriptionGracePeriod)
        pricePoints = try values.decodeIfPresent(PricePointsElement.self, forKey: .pricePoints)
        appCustomProductPages = try values.decodeIfPresent(AppCustomProductPagesElement.self, forKey: .appCustomProductPages)
        preOrder = try values.decodeIfPresent(PreOrderElement.self, forKey: .preOrder)
        appInfos = try values.decodeIfPresent(AppInfosElement.self, forKey: .appInfos)
        appStoreVersions = try values.decodeIfPresent(AppStoreVersionsElement.self, forKey: .appStoreVersions)
        prices = try values.decodeIfPresent(PricesElement.self, forKey: .prices)
    }
}
