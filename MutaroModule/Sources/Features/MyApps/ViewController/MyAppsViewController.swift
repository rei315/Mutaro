//
//  MyAppsViewController.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Combine
import Core
import ImageLoader
import JWTGenerator
import UIKit

public class MyAppsViewController: UIViewController {
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: configureLayout()
    )
    private lazy var dataSource: DataSource = self.configureDataSource()
    private let viewModel: MyAppsViewModel
    private let dependency: Dependency

    private let viewDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    private let viewWillAppearSubject: PassthroughSubject<Void, Never> = .init()
    private let didTapMyAppSubject: PassthroughSubject<(from: UIViewController, index: Int), Never> = .init()
    private let didTapRegisterJWTSubject: PassthroughSubject<UIViewController, Never> = .init()
    private let prefetchItemSubject: PassthroughSubject<MyAppsRow?, Never> = .init()
    private let cancelPrefetchItemSubject: PassthroughSubject<MyAppsRow?, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []

    public struct Dependency {
        let viewModel: MyAppsViewModel

        public init(viewModel: MyAppsViewModel) {
            self.viewModel = viewModel
        }
    }

    public init(dependency: Dependency) {
        self.dependency = dependency
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "MyApps"

        setupView()
        setupDefaultSnapshot()
        bind()
        viewDidLoadSubject.send()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewWillAppearSubject.send()
    }

    private func setupView() {
        collectionView.lets {
            $0.dataSource = dataSource
            $0.delegate = self
            $0.prefetchDataSource = self
            $0.registerClass(withType: MyAppsAppCell.self)
            $0.registerClass(withType: MyAppsRegisterJWTCell.self)
            view.addSubview($0)
            $0.fillConstraint(to: view)
        }
    }

    private func bind() {
        let output = viewModel.transform(
            input: .init(
                viewWillAppear: viewWillAppearSubject.eraseToAnyPublisher(),
                viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
                didTapMyApp: didTapMyAppSubject.eraseToAnyPublisher(),
                didTapRegisterJWT: didTapRegisterJWTSubject.eraseToAnyPublisher(),
                prefetchItem: prefetchItemSubject.eraseToAnyPublisher(),
                cancelPrefetch: cancelPrefetchItemSubject.eraseToAnyPublisher()
            )
        )

        output
            .showJWTRegister
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.updateRegisterJWTSnapshot(shuoldShow: $0)
            }
            .store(in: &cancellables)

        output
            .onUpdateAppInfos
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.updateAppsSnapshot(items: $0)
            }
            .store(in: &cancellables)
    }
}

extension MyAppsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        switch item {
        case .registerJWT:
            break
        case let .app(index):
            didTapMyAppSubject.send((from: self, index: index))
        }
    }
}

extension MyAppsViewController: UICollectionViewDataSourcePrefetching {
    public func collectionView(_: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let item = dataSource.itemIdentifier(for: indexPath)
            prefetchItemSubject.send(item)
        }
    }

    public func collectionView(_: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let item = dataSource.itemIdentifier(for: indexPath)
            cancelPrefetchItemSubject.send(item)
        }
    }
}

extension MyAppsViewController {
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        return .init(
            sectionProvider: { [weak self] sectionIndex, layoutEnvironment in
                guard let self else {
                    return nil
                }
                let section = self.dataSource.sectionIdentifier(for: sectionIndex)
                switch section {
                case .registerJWT:
                    let item = NSCollectionLayoutItem(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .estimated(200)
                        )
                    )
                    let groupLayout: NSCollectionLayoutSize = .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(200)
                    )
                    let group: NSCollectionLayoutGroup
                    if #available(iOS 16.0, *) {
                        group = NSCollectionLayoutGroup.vertical(
                            layoutSize: groupLayout,
                            repeatingSubitem: item,
                            count: 1
                        )
                    } else {
                        group = NSCollectionLayoutGroup.vertical(
                            layoutSize: groupLayout,
                            subitem: item,
                            count: 1
                        )
                    }
                    let section = NSCollectionLayoutSection(group: group)

                    let isEnabledToShowRegisterJWTSection = !self.dataSource
                        .snapshot()
                        .itemIdentifiers(inSection: .registerJWT)
                        .isEmpty

                    if isEnabledToShowRegisterJWTSection {
                        let backgroundItem = NSCollectionLayoutDecorationItem.background(
                            elementKind: MyAppsRegisterJWTSectionDecorationView.simpleClassName()
                        )
                        section.decorationItems = [backgroundItem]
                        section.contentInsets = .init(top: 12, leading: 20, bottom: 12, trailing: 20)
                    }

                    return section
                case .app:
                    let item = NSCollectionLayoutItem(
                        layoutSize: .init(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .estimated(300)
                        )
                    )

                    let groupLayout: NSCollectionLayoutSize = .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(300)
                    )
                    let group: NSCollectionLayoutGroup
                    if #available(iOS 16.0, *) {
                        group = NSCollectionLayoutGroup.vertical(
                            layoutSize: groupLayout,
                            repeatingSubitem: item,
                            count: 1
                        )
                    } else {
                        group = NSCollectionLayoutGroup.vertical(
                            layoutSize: groupLayout,
                            subitem: item,
                            count: 1
                        )
                    }

                    let section = NSCollectionLayoutSection(group: group)
                    let centerPadding = layoutEnvironment.container.contentSize.width / 3
                    section.contentInsets = .init(
                        top: 0,
                        leading: centerPadding,
                        bottom: 0,
                        trailing: centerPadding
                    )
                    section.interGroupSpacing = 20
                    section.contentInsetsReference = .none
                    return section
                case .none:
                    return nil
                }
            },
            configuration: config
        ).apply {
            $0.register(
                MyAppsRegisterJWTSectionDecorationView.self,
                forDecorationViewOfKind: MyAppsRegisterJWTSectionDecorationView.simpleClassName()
            )
        }
    }
}

extension MyAppsViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<MyAppsSection, MyAppsRow>
    enum MyAppsSection: Int, CaseIterable {
        case registerJWT
        case app
    }

    enum MyAppsRow: Hashable {
        case registerJWT
        case app(index: Int)
    }

    private func setupDefaultSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(MyAppsSection.allCases)
        dataSource.apply(snapshot)
    }

    private func updateAppsSnapshot(items: [AppInfo]) {
        var snapshot = dataSource.snapshot()
        let currentAppRows = snapshot.itemIdentifiers(inSection: .app)
        items
            .indices
            .map {
                MyAppsRow.app(index: $0)
            }
            .forEach {
                if currentAppRows.contains($0) {
                    snapshot.reconfigureItems([$0])
                } else {
                    snapshot.appendItems([$0], toSection: .app)
                }
            }

        let itemCount = items.count
        let itemCountDiff = currentAppRows.count - itemCount
        if itemCountDiff > 0 {
            let deleteTargets = (itemCount..<itemCount + itemCountDiff).map {
                MyAppsRow.app(index: $0)
            }
            snapshot.deleteItems(deleteTargets)
        }

        dataSource.apply(snapshot)
    }

    private func updateRegisterJWTSnapshot(shuoldShow: Bool) {
        var snapshot = dataSource.snapshot()
        let currentRows = snapshot.itemIdentifiers(inSection: .registerJWT)
        if shuoldShow {
            if currentRows.contains(.registerJWT) {
                snapshot.reconfigureItems([.registerJWT])
            } else {
                snapshot.appendItems([.registerJWT], toSection: .registerJWT)
            }
        } else {
            snapshot.deleteItems(currentRows)
        }

        dataSource.apply(snapshot)
    }

    private func configureDataSource() -> DataSource {
        let dataSource: DataSource = .init(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, item in
            guard let self else {
                return collectionView.dequeueReusableCell(
                    withType: UICollectionViewCell.self,
                    for: indexPath
                )
            }
            return self.cellProvider(
                collectionView: collectionView,
                indexPath: indexPath,
                item: item
            )
        }
        return dataSource
    }

    private func cellProvider(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: MyAppsRow
    ) -> UICollectionViewCell {
        switch item {
        case let .app(index):
            let cell = collectionView.dequeueReusableCell(
                withType: MyAppsAppCell.self,
                for: indexPath
            ).apply {
                if let item = viewModel.getAppInfos(index) {
                    $0.bind(url: item.iconUrl, title: item.name)
                }
            }

            return cell
        case .registerJWT:
            let cell = collectionView.dequeueReusableCell(
                withType: MyAppsRegisterJWTCell.self,
                for: indexPath
            ).apply {
                $0.bind { [weak self] in
                    guard let self else {
                        return
                    }
                    self.didTapRegisterJWTSubject.send(self)
                }
            }
            return cell
        }
    }
}
