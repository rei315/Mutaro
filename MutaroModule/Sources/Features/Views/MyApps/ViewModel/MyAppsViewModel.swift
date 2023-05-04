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

    func loadStoredJWTInfo() {
        guard let storedJWTInfo = try? KeychainStore.shared.get(MutaroJWT.JWTRequestInfo.self).first else {
            // TODO: - show need to register
            print("Mins: failed get stored jwt info")
            return
        }

        guard let currentSavedJWTInfo = currentJWTInfo.value, currentSavedJWTInfo != storedJWTInfo else {
            currentJWTInfo.send(storedJWTInfo)
            return
        }
    }

    func test(storedJWTInfo: MutaroJWT.JWTRequestInfo) {
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
            let myAppsEndpoint = MyAppsEndpoint.GetAllListMyApps(token: token)
            let myAppsResult = await Provider.shared.request(endpoint: myAppsEndpoint, responseModel: MyAppsElement.self)
            switch myAppsResult {
            case let .success(myAppsElement):
                let appId = myAppsElement.data?.first?.id ?? ""
                let buildsParametr = [
                    "filter[app]": appId,
                    "sort": "-uploadedDate",
                    "limit": 1
                ]
                let buildsEndpoint = BuildsEndpoint.GetAllBuilds(token: token, additionalParameters: buildsParametr)
                let buildsResult = await Provider.shared.request(endpoint: buildsEndpoint, responseModel: BuildsElement.self)
                switch buildsResult {
                case let .success(buildsElement):
                    print("Mins: \(buildsElement)")
                case .failure:
                    break
                }
            case .failure:
                print("Mins: failed client")
            }
        }
    }
}
