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
            data: data?.compactMap {
                CIProductsEntity.CIProductsData(
                    id: $0.id,
                    type: $0.type,
                    attributes: .init(
                        name: $0.attributes?.name,
                        createdDate: $0.attributes?.createdDate,
                        productType: $0.attributes?.productType
                    ),
                    relationships: .init(
                        app: .init(
                            links: .init(
                                related: $0.relationships?.app?.links?.related,
                                linksSelf: $0.relationships?.app?.links?.linksSelf
                            )
                        ),
                        workflows: .init(
                            links: .init(
                                related: $0.relationships?.workflows?.links?.related,
                                linksSelf: $0.relationships?.workflows?.links?.linksSelf
                            )
                        ),
                        primaryRepositories: .init(
                            links: .init(
                                related: $0.relationships?.primaryRepositories?.links?.related,
                                linksSelf: $0.relationships?.primaryRepositories?.links?.linksSelf
                            )
                        ),
                        additionalRepositories: .init(
                            links: .init(
                                related: $0.relationships?.additionalRepositories?.links?.related,
                                linksSelf: $0.relationships?.additionalRepositories?.links?.linksSelf
                            )
                        ),
                        buildRuns: .init(
                            links: .init(
                                related: $0.relationships?.buildRuns?.links?.related,
                                linksSelf: $0.relationships?.buildRuns?.links?.linksSelf
                            )
                        )
                    ),
                    links: .init(
                        linksSelf: $0.links?.linksSelf
                    )
                )
            }
        )
    }
}
