//
//  MyAppsDTO+Map.swift
//
//
//  Created by minguk-kim on 2023/05/21.
//

import Core
import Foundation

public extension MyAppsDTO {
    func toEntity() -> MyAppsEntity {
        .init(
            links: .init(
                linksSelf: links?.linksSelf
            ),
            data: data?.compactMap {
                MyAppsEntity.MyAppsData(
                    id: $0.id,
                    relationships: .init(
                        reviewSubmissions: .init(
                            links: .init(
                                related: $0.relationships?.reviewSubmissions?.links?.related,
                                linksSelf: $0.relationships?.reviewSubmissions?.links?.linksSelf
                            )
                        ),
                        betaAppLocalizations: .init(
                            links: .init(
                                related: $0.relationships?.betaAppLocalizations?.links?.related,
                                linksSelf: $0.relationships?.betaAppLocalizations?.links?.linksSelf
                            )
                        ),
                        promotedPurchases: .init(
                            links: .init(
                                related: $0.relationships?.promotedPurchases?.links?.related,
                                linksSelf: $0.relationships?.promotedPurchases?.links?.linksSelf
                            )
                        ),
                        ciProduct: .init(
                            links: .init(
                                related: $0.relationships?.ciProduct?.links?.related,
                                linksSelf: $0.relationships?.ciProduct?.links?.linksSelf
                            )
                        ),
                        appClips: .init(
                            links: .init(
                                related: $0.relationships?.appClips?.links?.related,
                                linksSelf: $0.relationships?.appClips?.links?.linksSelf
                            )
                        ),
                        betaTesters: .init(
                            links: .init(
                                linksSelf: $0.relationships?.betaTesters?.links?.linksSelf
                            )
                        ),
                        inAppPurchases: .init(
                            links: .init(
                                related: $0.relationships?.inAppPurchases?.links?.related,
                                linksSelf: $0.relationships?.inAppPurchases?.links?.linksSelf
                            )
                        ),
                        appAvailability: .init(
                            links: .init(
                                related: $0.relationships?.appAvailability?.links?.related,
                                linksSelf: $0.relationships?.appAvailability?.links?.linksSelf
                            )
                        ),
                        preReleaseVersions: .init(
                            links: .init(
                                related: $0.relationships?.preReleaseVersions?.links?.related,
                                linksSelf: $0.relationships?.preReleaseVersions?.links?.linksSelf
                            )
                        ),
                        appPricePoints: .init(
                            links: .init(
                                related: $0.relationships?.appPricePoints?.links?.related,
                                linksSelf: $0.relationships?.appPricePoints?.links?.linksSelf
                            )
                        ),
                        betaAppReviewDetail: .init(
                            links: .init(
                                related: $0.relationships?.betaAppReviewDetail?.links?.related,
                                linksSelf: $0.relationships?.betaAppReviewDetail?.links?.linksSelf
                            )
                        ),
                        builds: .init(
                            links: .init(
                                related: $0.relationships?.builds?.links?.related,
                                linksSelf: $0.relationships?.builds?.links?.linksSelf
                            )
                        ),
                        availableTerritories: .init(
                            links: .init(
                                related: $0.relationships?.availableTerritories?.links?.related,
                                linksSelf: $0.relationships?.availableTerritories?.links?.linksSelf
                            )
                        ),
                        inAppPurchasesV2: .init(
                            links: .init(
                                related: $0.relationships?.inAppPurchasesV2?.links?.related,
                                linksSelf: $0.relationships?.inAppPurchasesV2?.links?.linksSelf
                            )
                        ),
                        customerReviews: .init(
                            links: .init(
                                related: $0.relationships?.customerReviews?.links?.related,
                                linksSelf: $0.relationships?.customerReviews?.links?.linksSelf
                            )
                        ),
                        betaGroups: .init(
                            links: .init(
                                related: $0.relationships?.betaGroups?.links?.related,
                                linksSelf: $0.relationships?.betaGroups?.links?.linksSelf
                            )
                        ),
                        betaLicenseAgreement: .init(
                            links: .init(
                                related: $0.relationships?.betaLicenseAgreement?.links?.related,
                                linksSelf: $0.relationships?.betaLicenseAgreement?.links?.linksSelf
                            )
                        ),
                        endUserLicenseAgreement: .init(
                            links: .init(
                                related: $0.relationships?.endUserLicenseAgreement?.links?.related,
                                linksSelf: $0.relationships?.endUserLicenseAgreement?.links?.linksSelf
                            )
                        ),
                        appPriceSchedule: .init(
                            links: .init(
                                related: $0.relationships?.appPriceSchedule?.links?.related,
                                linksSelf: $0.relationships?.appPriceSchedule?.links?.linksSelf
                            )
                        ),
                        subscriptionGroups: .init(
                            links: .init(
                                related: $0.relationships?.subscriptionGroups?.links?.related,
                                linksSelf: $0.relationships?.subscriptionGroups?.links?.linksSelf
                            )
                        ),
                        gameCenterEnabledVersions: .init(
                            links: .init(
                                related: $0.relationships?.gameCenterEnabledVersions?.links?.related,
                                linksSelf: $0.relationships?.gameCenterEnabledVersions?.links?.linksSelf
                            )
                        ),
                        perfPowerMetrics: .init(
                            links: .init(
                                related: $0.relationships?.perfPowerMetrics?.links?.related
                            )
                        ),
                        appEvents: .init(
                            links: .init(
                                related: $0.relationships?.appEvents?.links?.related,
                                linksSelf: $0.relationships?.appEvents?.links?.linksSelf
                            )
                        ),
                        subscriptionGracePeriod: .init(
                            links: .init(
                                related: $0.relationships?.subscriptionGracePeriod?.links?.related,
                                linksSelf: $0.relationships?.subscriptionGroups?.links?.linksSelf
                            )
                        ),
                        pricePoints: .init(
                            links: .init(
                                related: $0.relationships?.pricePoints?.links?.related,
                                linksSelf: $0.relationships?.pricePoints?.links?.linksSelf
                            )
                        ),
                        appCustomProductPages: .init(
                            links: .init(
                                related: $0.relationships?.appCustomProductPages?.links?.related,
                                linksSelf: $0.relationships?.appCustomProductPages?.links?.linksSelf
                            )
                        ),
                        preOrder: .init(
                            links: .init(
                                related: $0.relationships?.preOrder?.links?.related,
                                linksSelf: $0.relationships?.preOrder?.links?.linksSelf
                            )
                        ),
                        appInfos: .init(
                            links: .init(
                                related: $0.relationships?.appInfos?.links?.related,
                                linksSelf: $0.relationships?.appInfos?.links?.linksSelf
                            )
                        ),
                        appStoreVersions: .init(
                            links: .init(
                                related: $0.relationships?.appStoreVersions?.links?.related,
                                linksSelf: $0.relationships?.appStoreVersions?.links?.linksSelf
                            )
                        ),
                        prices: .init(
                            links: .init(
                                related: $0.relationships?.prices?.links?.related,
                                linksSelf: $0.relationships?.prices?.links?.linksSelf
                            )
                        )
                    ),
                    links: .init(
                        linksSelf: $0.links?.linksSelf
                    ),
                    type: $0.type,
                    attributes: .init(
                        subscriptionStatusURLVersionForSandbox: $0.attributes?.subscriptionStatusURLVersionForSandbox,
                        subscriptionStatusURLVersion: $0.attributes?.subscriptionStatusURLVersion,
                        availableInNewTerritories: $0.attributes?.availableInNewTerritories,
                        sku: $0.attributes?.sku,
                        contentRightsDeclaration: $0.attributes?.contentRightsDeclaration,
                        bundleID: $0.attributes?.bundleID,
                        primaryLocale: $0.attributes?.primaryLocale,
                        subscriptionStatusURL: $0.attributes?.subscriptionStatusURL,
                        subscriptionStatusURLForSandbox: $0.attributes?.subscriptionStatusURLForSandbox,
                        name: $0.attributes?.name,
                        isOrEverWasMadeForKids: $0.attributes?.isOrEverWasMadeForKids
                    )
                )
            },
            meta: .init(
                paging: .init(
                    total: meta?.paging?.total,
                    limit: meta?.paging?.limit
                )
            )
        )
    }
}
