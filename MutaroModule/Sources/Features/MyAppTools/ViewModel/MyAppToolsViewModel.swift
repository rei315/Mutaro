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

    func transform(input: Input) -> Output {
        let viewDidLoad = input
            .viewDidLoad
            .share()

        let ciProducts = viewDidLoad
            .asyncMap { await self.model.getCIProducts() }
            .eraseToAnyPublisher()
            .share()

        ciProducts
            .assign(to: \.value, on: ciProductsItem)
            .store(in: &cancellables)

        ciProducts
            .compactMap { _ in MyAppToolsModel.ItemType.xcodeCloud }
            .sink { [weak self] type in
                guard let self,
                      !self.items.value.contains(type) else {
                    return
                }
                var results = self.items.value
                results.append(type)
                self.items.send(results)
            }
            .store(in: &cancellables)

        input
            .didTapItem
            .asyncSink(taskCancellable: taskCancellable) { [weak self] in
                await self?.onTapItem($0)
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
