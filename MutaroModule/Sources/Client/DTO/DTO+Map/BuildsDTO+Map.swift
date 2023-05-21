//
//  BuildsDTO+Map.swift
//
//
//  Created by minguk-kim on 2023/05/21.
//

import Core
import Foundation

public extension BuildsDTO {
    func toEntity() -> BuildsEntity {
        .init(
            links: .init(
                linksSelf: links?.linksSelf
            ),
            data: data?.compactMap {
                .init(
                    id: $0.id,
                    relationships: .init(
                        betaAppReviewSubmission: .init(
                            links: .init(
                                related: $0.relationships?.betaAppReviewSubmission?.links?.related,
                                linksSelf: $0.relationships?.betaAppReviewSubmission?.links?.linksSelf
                            )
                        ),
                        appStoreVersion: .init(
                            links: .init(
                                related: $0.relationships?.appStoreVersion?.links?.related,
                                linksSelf: $0.relationships?.appStoreVersion?.links?.linksSelf
                            )
                        ),
                        appEncryptionDeclaration: .init(
                            links: .init(
                                related: $0.relationships?.appEncryptionDeclaration?.links?.related,
                                linksSelf: $0.relationships?.appEncryptionDeclaration?.links?.linksSelf
                            )
                        ),
                        individualTesters: .init(
                            links: .init(
                                related: $0.relationships?.individualTesters?.links?.related,
                                linksSelf: $0.relationships?.individualTesters?.links?.linksSelf
                            )
                        ),
                        perfPowerMetrics: .init(
                            links: .init(
                                related: $0.relationships?.perfPowerMetrics?.links?.related
                            )
                        ),
                        betaBuildLocalizations: .init(
                            links: .init(
                                related: $0.relationships?.betaBuildLocalizations?.links?.related,
                                linksSelf: $0.relationships?.betaBuildLocalizations?.links?.linksSelf
                            )
                        ),
                        betaGroups: .init(
                            links: .init(
                                linksSelf: $0.relationships?.betaGroups?.links?.linksSelf
                            )
                        ),
                        app: .init(
                            links: .init(
                                related: $0.relationships?.app?.links?.related,
                                linksSelf: $0.relationships?.app?.links?.linksSelf
                            )
                        ),
                        diagnosticSignatures: .init(
                            links: .init(
                                related: $0.relationships?.diagnosticSignatures?.links?.related,
                                linksSelf: $0.relationships?.diagnosticSignatures?.links?.linksSelf
                            )
                        ),
                        preReleaseVersion: .init(
                            links: .init(
                                related: $0.relationships?.preReleaseVersion?.links?.related,
                                linksSelf: $0.relationships?.preReleaseVersion?.links?.linksSelf
                            )
                        ),
                        buildBetaDetail: .init(
                            links: .init(
                                related: $0.relationships?.buildBetaDetail?.links?.related,
                                linksSelf: $0.relationships?.buildBetaDetail?.links?.linksSelf
                            )
                        ),
                        icons: .init(
                            links: .init(
                                related: $0.relationships?.icons?.links?.related,
                                linksSelf: $0.relationships?.icons?.links?.linksSelf
                            )
                        )
                    ),
                    links: .init(
                        linksSelf: $0.links?.linksSelf
                    ),
                    type: $0.type,
                    attributes: .init(
                        expirationDate: $0.attributes?.expirationDate,
                        expired: $0.attributes?.expired,
                        processingState: $0.attributes?.processingState,
                        buildAudienceType: $0.attributes?.buildAudienceType,
                        minOSVersion: $0.attributes?.minOSVersion,
                        iconAssetToken: .init(
                            width: $0.attributes?.iconAssetToken?.width,
                            templateURL: $0.attributes?.iconAssetToken?.templateURL,
                            height: $0.attributes?.iconAssetToken?.height
                        ),
                        version: $0.attributes?.version,
                        uploadedDate: $0.attributes?.uploadedDate,
                        lsMinimumSystemVersion: $0.attributes?.lsMinimumSystemVersion,
                        computedMinMACOSVersion: $0.attributes?.computedMinMACOSVersion,
                        usesNonExemptEncryption: $0.attributes?.usesNonExemptEncryption
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
