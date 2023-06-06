//
//  CIProductUseCase.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Client
import Core
import Foundation
import JWTGenerator

public protocol CIProductUseCase {}

public final class CIProductUseCaseImp: CIProductUseCase {
    private let client: Providable

    public init(client: Providable) {
        self.client = client
    }
}
