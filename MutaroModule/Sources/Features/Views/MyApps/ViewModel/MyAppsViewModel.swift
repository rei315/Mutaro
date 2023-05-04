//
//  MyAppsViewModel.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Client
import Combine
import Core
import Foundation
import JWTGenerator
import KeychainStore

protocol MyAppsViewModelProtocol {}

public final class MyAppsViewModel: NSObject, MyAppsViewModelProtocol {
    typealias Routes = MyAppsRoute
    private let router: Routes
    let currentJWTInfo = CurrentValueSubject<MutaroJWT.JWTRequestInfo?, Never>(nil)

    var cancellables: Set<AnyCancellable> = []

    init(router: Routes) {
        self.router = router
    }

    func generateJWTString() {
        guard let storedJWTInfo = try? KeychainStore.shared.get(MutaroJWT.JWTRequestInfo.self).first else {
            // TODO: - show need to register
            print("Mins: failed get stored jwt info")
            return
        }

        currentJWTInfo.send(storedJWTInfo)

        let builder = MutaroJWT.AppstoreConnectJWTBuilder(
            keyId: storedJWTInfo.keyID,
            issuerId: storedJWTInfo.issuerID,
            pemString: storedJWTInfo.privateKey
        )
        guard let token = try? builder.generateJWT() else {
            // TODO: - show need to register
            print("Mins: failed generate token")
            return
        }
        Task {
            let endpoint = MyAppsEndpoint.GetAllListMyApps(token: token)
            let result = await Provider.shared.request(endpoint: endpoint)
            switch result {
            case let .success(data):
                let dictonary = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                print("Mins: \(dictonary)")
            case .failure:
                print("Mins: failed client")
            }
        }
    }
}
