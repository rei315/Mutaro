//
//  CIProductsDTO+Map.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import Foundation

public extension CIProductsDTO {
    func toEntity() -> CIProductsEntity {
        .init(
            links: .init(
                linksSelf: links?.linksSelf
            ),
            data: .init(
                id: data?.id,
                type: data?.type,
                attributes: .init(
                    name: data?.attributes?.name,
                    createdDate: data?.attributes?.createdDate,
                    productType: data?.attributes?.productType
                ),
                relationships: .init(
                    app: .init(
                        links: .init(
                            related: data?.relationships?.app?.links?.related,
                            linksSelf: data?.relationships?.app?.links?.linksSelf
                        )
                    ),
                    workflows: .init(
                        links: .init(
                            related: data?.relationships?.workflows?.links?.related,
                            linksSelf: data?.relationships?.workflows?.links?.linksSelf
                        )
                    ),
                    primaryRepositories: .init(
                        links: .init(
                            related: data?.relationships?.primaryRepositories?.links?.related,
                            linksSelf: data?.relationships?.primaryRepositories?.links?.linksSelf
                        )
                    ),
                    additionalRepositories: .init(
                        links: .init(
                            related: data?.relationships?.additionalRepositories?.links?.related,
                            linksSelf: data?.relationships?.additionalRepositories?.links?.linksSelf
                        )
                    ),
                    buildRuns: .init(
                        links: .init(
                            related: data?.relationships?.buildRuns?.links?.related,
                            linksSelf: data?.relationships?.buildRuns?.links?.linksSelf
                        )
                    )
                ),
                links: .init(
                    linksSelf: data?.links?.linksSelf
                )
            )
        )
    }
}
