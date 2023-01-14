//
//  NSItemProvider+Extensions.swift
//
//
//  Created by minguk-kim on 2023/01/13.
//

import Foundation

extension NSItemProvider {
    public func loadObject(ofClass aClass: NSItemProviderReading.Type) async throws
        -> NSItemProviderReading
    {
        try await withCheckedThrowingContinuation { continuation in
            self.loadObject(ofClass: aClass) { data, error in
                if let error {
                    return continuation.resume(throwing: error)
                }

                guard let data else {
                    return continuation.resume(throwing: NSError())
                }

                continuation.resume(returning: data)
            }.resume()
        }
    }

    public func loadItem(forTypeIdentifier typeIdentifier: String) async throws -> URL {
        try await withCheckedThrowingContinuation { continuation in
            self.loadItem(forTypeIdentifier: typeIdentifier) { url, error in
                if let error {
                    return continuation.resume(throwing: error)
                }

                guard let url = url as? URL else {
                    return continuation.resume(throwing: NSError())
                }

                continuation.resume(returning: url)
            }
        }
    }
}
