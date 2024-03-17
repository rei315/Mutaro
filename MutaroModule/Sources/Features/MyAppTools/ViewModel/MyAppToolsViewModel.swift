//
//  MyAppToolsViewModel.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Combine
import Core
import Foundation

@MainActor
protocol MyAppToolsViewModelProtocol {
    func transform(input: MyAppToolsViewModel.Input) -> MyAppToolsViewModel.Output
}

extension MyAppToolsViewModel {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let didTapItem: AnyPublisher<MyAppToolsModel.ItemType, Never>
    }

    struct Output {
        let onUpdateItems: AnyPublisher<[MyAppToolsModel.ItemType], Never>
    }
}

@MainActor
public final class MyAppToolsViewModel: MyAppToolsViewModelProtocol, Sendable {
    private let appId: String
    private let environment: MyAppToolsFeatureEnvironment
    var cancellables: Set<AnyCancellable> = []
    let taskCancellable = TaskCancellable()

    private lazy var model: MyAppToolsModel = .init(
        appId: appId,
        ciProductUseCase: environment.ciProductUseCase,
        keychainDataStore: environment.keychainDataStore
    )

    private let items: CurrentValueSubject<[MyAppToolsModel.ItemType], Never> = .init([])
    private let ciProductsItem: CurrentValueSubject<CIProductsEntity.CIProductsData?, Never> = .init(nil)

    public init(
        appId: String,
        environment: MyAppToolsFeatureEnvironment
    ) {
        self.appId = appId
        self.environment = environment
    }

    private func fetch() async {
        let ciProducts = await model.getCIProducts()
        ciProductsItem.send(ciProducts)

        if !items.value.contains(.xcodeCloud) {
            var results = items.value
            results.append(.xcodeCloud)
            items.send(results)
        }
    }

    func transform(input: Input) -> Output {
        input
            .viewDidLoad
            .sink { [weak self] in
                Task {
                    await self?.fetch()
                }
            }
            .store(in: &cancellables)

        input
            .didTapItem
            .sink { [weak self] item in
                Task {
                    await self?.onTapItem(item)
                }
            }
            .store(in: &cancellables)

        return .init(
            onUpdateItems: items.eraseToAnyPublisher()
        )
    }

    private func onTapItem(_ type: MyAppToolsModel.ItemType) async {
        switch type {
        case .xcodeCloud:
            await showXcodeCloudDetail()
        }
    }

    private func showXcodeCloudDetail() async {
//        let data = await model.getXcodeCloudData()
    }
}

extension MyAppToolsViewModel {
    struct ToolItem {
        var ciProductsData: CIProductsEntity.CIProductsData?

        init(ciProductsData: CIProductsEntity.CIProductsData? = nil) {
            self.ciProductsData = ciProductsData
        }
    }
}
