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
    static func postMutaros(imageUrl: String, title: String, description: String) async throws
}

extension MutaroClient {
    public struct MutaroDetailResource: MutaroDetailResourceProtocol {
        public static func postMutaros(imageUrl: String, title: String, description: String) async throws {
            guard await NWPathMonitor().isOnline() else {
                throw NSError()
            }
            
            let collection = MutaroClient.shared.firestore.collection("mutaroDetails")
            let dateFormatter = DateFormatter().apply {
                $0.dateFormat = "yyyy/MM/dd HH:mm"
                $0.calendar = Calendar(identifier: .gregorian)
                $0.locale = Locale(identifier: "ja_JP")
                $0.timeZone = TimeZone(identifier: "Asia/Tokyo")
            }
            let uploadDateString = dateFormatter.string(from: Date())
            let dto = MutaroDTO(
                uploadDate: uploadDateString,
                imageUrl: imageUrl,
                title: title,
                description: description
            )
            
            let data = try JSONEncoder().encode(dto)
            guard let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                throw NSError()
            }
            
            try await collection.document().setData(dictionary)
        }
        
        public static func getMutaros() async throws -> [MutaroDTO] {            
            guard await NWPathMonitor().isOnline() else {
                throw NSError()
            }
            let collection = MutaroClient.shared.firestore.collection("mutaroDetails")
            let snapshot = try await collection.getDocuments()

            let mutaroDetails = snapshot.documents
                .filter({ $0.exists })
                .compactMap { document -> MutaroDTO? in
                    do {
                        let mutaroDetail = document.data()
                        let data = try JSONSerialization.data(withJSONObject: mutaroDetail, options: .prettyPrinted)
                        let decoder = JSONDecoder()
                        let dto = try decoder.decode(MutaroDTO.self, from: data)
                        return dto
                    } catch {
                        return nil
                    }
                }
                .compactMap { $0 }

            return mutaroDetails
        }
    }
}
