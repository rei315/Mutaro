//
//  XCTestCase+Extensions.swift
//
//
//  Created by minguk-kim on 2023/08/06.
//

import Foundation
import SnapshotTesting
import SwiftUI
import XCTest

public extension XCTestCase {
    #if os(iOS)
        func assertPreviewSnapshot<T: PreviewProvider>(
            _: T.Type,
            file: StaticString = #file,
            testName: String = #function,
            line: UInt = #line
        ) {
            for preview in T._allPreviews {
                assertCustomSnapshot(
                    matching: preview.content.toViewController(),
                    as: .image(on: .iPhone13),
                    testBundleResourceURL: Bundle.module.resourceURL!,
                    file: file,
                    testName: testName,
                    line: line
                )
            }
        }

        func assertCustomSnapshot(
            viewController: UIViewController,
            file: StaticString = #file,
            testName: String = #function,
            line: UInt = #line
        ) {
            assertCustomSnapshot(
                matching: viewController,
                as: .image(on: .iPhone13),
                testBundleResourceURL: Bundle.module.resourceURL!,
                file: file,
                testName: testName,
                line: line
            )
        }

        private func assertCustomSnapshot<Value>(
            matching value: @autoclosure () throws -> Value,
            as snapshotting: Snapshotting<Value, some Any>,
            testBundleResourceURL: URL,
            file: StaticString = #file,
            testName: String = #function,
            line: UInt = #line
        ) {
            if #available(iOS 16.0, *) {
                let testClassFileURL = URL(fileURLWithPath: "\(file)", isDirectory: false)
                let testClassName = testClassFileURL.deletingPathExtension().lastPathComponent

                let folderCandidates = [
                    testBundleResourceURL.appending(path: "__Snapshots__").appending(path: testClassName),

                    testBundleResourceURL.appending(path: testClassName)
                ]

                var snapshotDirectory: String?

                for folder in folderCandidates {
                    let referenceSnapshotURLInTestBundle = folder.appending(path: "\(sanitizePathComponent(testName)).png")
                    if FileManager.default.fileExists(atPath: referenceSnapshotURLInTestBundle.path(percentEncoded: false)) {
                        snapshotDirectory = folder.path(percentEncoded: false)
                    }
                }
                let failure = try SnapshotTesting.verifySnapshot(
                    matching: value(),
                    as: snapshotting,
                    named: nil,
                    record: false,
                    snapshotDirectory: snapshotDirectory,
                    file: file,
                    testName: testName,
                    line: line
                )

                if let message = failure {
                    XCTFail(message, file: file, line: line)
                }
            }
        }

        func sanitizePathComponent(_ string: String) -> String {
            string
                .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
                .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
        }
    #endif
}
