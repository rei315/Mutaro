//
//  MutaroDetailResource.swift
//
//
//  Created by minguk-kim on 2023/01/05.
//

import Foundation
import Network

public protocol MutaroDetailResourceProtocol {
    static func getMutaros() async throws -> [MutaroDTO]
}

extension MutaroClient {
    public struct MutaroDetailResource: MutaroDetailResourceProtocol {
        public static func getMutaros() async throws -> [MutaroDTO] {            
            guard await NWPathMonitor().isOnline() else {
                return []
            }
            let collection = MutaroClient.shared.firestore.collection("mutaroDetails")
            let snapshot = try await collection.getDocuments()

            let mutaroDetails = snapshot.documents
                .filter({ $0.exists })
                .compactMap { document -> MutaroDTO? in
                    let mutaroDetail = document.data()
                    guard let id = mutaroDetail["id"] as? Int,
                        let imageUrl = mutaroDetail["imageUrl"] as? String,
                        let title = mutaroDetail["title"] as? String,
                        let description = mutaroDetail["description"] as? String
                    else {
                        return nil
                    }
                    return MutaroDTO(
                        id: id,
                        imageUrl: imageUrl,
                        title: title,
                        description: description
                    )
                }
                .compactMap { $0 }

            return mutaroDetails
        }
    }
}
