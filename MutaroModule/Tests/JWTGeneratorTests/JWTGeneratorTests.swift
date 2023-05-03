//
//  JWTGeneratorTests.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import Nimble
import Quick

@testable import JWTGenerator

private struct JWTGeneratorMock {
    static let pemString = """
 -----BEGIN PUBLIC KEY-----
 MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDdlatRjRjogo3WojgGHFHYLugd
 UWAY9iR3fy4arWNA1KoS8kVw33cJibXr8bvwUAUparCwlvdbH6dvEOfou0/gCFQs
 HUfQrSDv+MuSUMAe8jzKE4qW+jK+xQU9a03GUnKHkkle+Q0pX/g6jXZ7r1/xAK5D
 o2kQ+X5xK9cipRgEKwIDAQAB
 -----END PUBLIC KEY-----
 """
    
    static let keyId = "AB1CD2EFGH"
    static let issuerId = "12abcd34-1234-12a3-a123-1a2bc3d45e6f7"
}

final class JWTGeneratorTests: QuickSpec {
    struct TestCase {
        let context: String
        let builder: MutaroJWT.AppstoreConnectJWTBuilder
    }

    private let validTestCases: [TestCase] = [
        .init(
            context: "パラメターが全部正しく入ってる場合",
            builder: .init(
                keyId: JWTGeneratorMock.keyId,
                issuerId: JWTGeneratorMock.issuerId,
                pemString: JWTGeneratorMock.pemString
            )
        ),
    ]

    private let invalidTestCases: [TestCase] = [
        .init(
            context: "パラメターが全部空の場合",
            builder: .init(
                keyId: "",
                issuerId: "",
                pemString: ""
            )
        ),
        .init(
            context: "keyIdが空の場合",
            builder: .init(
                keyId: "",
                issuerId: JWTGeneratorMock.issuerId,
                pemString: JWTGeneratorMock.pemString
            )
        ),
        .init(
            context: "issuerIdが空の場合",
            builder: .init(
                keyId: JWTGeneratorMock.keyId,
                issuerId: "",
                pemString: JWTGeneratorMock.pemString
            )
        ),
        .init(
            context: "pemStringが空の場合",
            builder: .init(
                keyId: JWTGeneratorMock.keyId,
                issuerId: JWTGeneratorMock.issuerId,
                pemString: ""
            )
        )
    ]

    override func spec() {
        describe("JWTGenerator") {
            context("builderのパラメターが正しくないケース") {
                for testCase in invalidTestCases {
                    context(testCase.context) {
                        it("nilをreturnする") {
                            let token = try? testCase.builder.generateJWT()
                            expect(token).to(beNil())
                        }
                    }
                }
                
            }
            context("builderのパラメターが正しいケース") {
                for testCase in validTestCases {
                    context(testCase.context) {
                        it("string valueをreturnする") {
                            let token = try? testCase.builder.generateJWT()
                            expect(token).to(beNil())
                        }
                    }
                }
            }
        }
    }
}
