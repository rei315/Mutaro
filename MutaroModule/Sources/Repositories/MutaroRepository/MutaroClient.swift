//
//  MutaroClient.swift
//
//
//  Created by minguk-kim on 2023/01/04.
//

import Core
import FirebaseFirestore
import Foundation

public final class MutaroClient {
    public static let shared = MutaroClient()

    public let firestore = Firestore.firestore()
}
