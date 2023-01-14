//
//  File.swift
//  
//
//  Created by minguk-kim on 2023/01/14.
//

import Foundation
import Network

public protocol MutaroPhotoResourceProtocol {
    static func postMutaroPhoto(fileUrl: URL, fileName: String) async throws -> String
}

extension MutaroClient {
    public struct MutaroPhotoResource: MutaroPhotoResourceProtocol {
        public static func postMutaroPhoto(fileUrl: URL, fileName: String) async throws -> String {
            guard await NWPathMonitor().isOnline() else {
                throw NSError()
            }
            
            let fileData = try Data(contentsOf: fileUrl)
            let ref = MutaroClient.shared.storage.reference().child("mutaro_photos/\(fileName)")
            _ = try await ref.putDataAsync(fileData)
            let downloadUrl = try await ref.downloadURL()
            
            return downloadUrl.absoluteString
        }
    }
}
