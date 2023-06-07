//
//  MyAppToolsViewModel.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Combine
import Core
import Foundation

public class MyAppToolsViewModel {
    private let appId: String
    private let environment: MyAppToolsFeatureEnvironment
    var cancellables: Set<AnyCancellable> = []
    let taskCancellable = TaskCancellable()

    private lazy var model: MyAppToolsModel = .init(
        appId: appId,
        ciProductUseCase: environment.ciProductUseCase
    )

    @currentPublished private(set) var items: [MyAppToolsModel.ItemType] = []

    public init(
        appId: String,
        environment: MyAppToolsFeatureEnvironment
    ) {
        self.appId = appId
        self.environment = environment
    }

    public func setupSubscription() async {
        model.itemTypeSubject
            .assign(to: \.value, on: $items)
            .store(in: &cancellables)
    }

    public func fetch() async {
        await model.fetch()
    }
}
