//
//  MutaroClient.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import CommonAppModule
import FirebaseFirestore
import Foundation
import ImageModule

protocol MutaroClientProtocol {
    func getMutaros() async throws -> [MutaroDTO]
}

public final class MutaroClient: MutaroClientProtocol {
    public static let shared = MutaroClient()

    private let firestore = Firestore.firestore()
    private let networkStatusManager: NetworkStatusManagerProtocol

    private init(networkStatusManager: NetworkStatusManagerProtocol = NetworkStatusManager()) {
        self.networkStatusManager = networkStatusManager
    }

    public func getMutaros() async throws -> [MutaroDTO] {
        if await networkStatusManager.isOnline {
            return []
        } else {
            let mutaroItems = MutaroContentType.allCases.indices
                .map { $0 }
                .compactMap { imageId -> MutaroDTO in
                    let imageUrl = "local://mutaro_\(imageId)"
                    let imageType = MutaroContentType(rawValue: imageId)
                    let imageTitle = imageType?.title ?? ""
                    let imageDescription = imageId.description

                    return .init(
                        id: imageId,
                        imageUrl: imageUrl,
                        title: imageTitle,
                        description: imageDescription
                    )
                }

            return mutaroItems
        }
    }
}
