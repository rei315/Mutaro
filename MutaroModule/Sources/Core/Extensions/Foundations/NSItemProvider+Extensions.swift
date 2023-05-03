//
//  NSItemProvider+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/13.
//

import Foundation

public extension NSItemProvider {
    func loadFileRepresentation(forTypeIdentifier typeIdentifier: String) async throws -> URL {
        try await withCheckedThrowingContinuation { continuation in
            self.loadFileRepresentation(forTypeIdentifier: typeIdentifier) { url, error in
                if let error {
                    return continuation.resume(throwing: error)
                }

                guard let url else {
                    return continuation.resume(throwing: NSError())
                }

                let localURL = FileManager.default.temporaryDirectory.appendingPathComponent(
                    url.lastPathComponent)
                try? FileManager.default.removeItem(at: localURL)

                do {
                    try FileManager.default.copyItem(at: url, to: localURL)
                } catch {
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: localURL)
            }.resume()
        }
    }
}
