//
//  MyAppToolsViewController.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Core
import UIKit

final class MyAppToolsViewController: UIViewController {
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: configureLayout()
    )
    private lazy var dataSource: DataSource = configureDataSource()

    private let viewModel: MyAppToolsViewModel
    private let dependency: Dependency

    private let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CellItem> { cell, _, item in
        var configuration = cell.myAppToolCellConfiguration()
        configuration.title = item.title
        cell.contentConfiguration = configuration
    }

    public struct Dependency {
        let viewModel: MyAppToolsViewModel

        public init(viewModel: MyAppToolsViewModel) {
            self.viewModel = viewModel
        }
    }

    public init(dependency: Dependency) {
        self.dependency = dependency
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSmallTitle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupDefaultSnapshot()
        setupSubscription()

        Task {
            await viewModel.setupSubscription()
            await viewModel.fetch()
        }
        .store(in: viewModel.taskCancellable)
    }

    private func setupView() {
        view.backgroundColor = .white

        collectionView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.dataSource = dataSource
            $0.delegate = self
            $0.fillConstraint(to: view)
        }
    }

    private func setupSubscription() {
        viewModel.$items
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.updateSnapshot(items: $0)
            }
            .store(in: &viewModel.cancellables)
    }
}

extension MyAppToolsViewController {
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.backgroundColor = .white

            let section = NSCollectionLayoutSection.list(
                using: configuration,
                layoutEnvironment: layoutEnvironment
            )
            return section
        }
    }
}

extension MyAppToolsViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<MyAppToolsSection, MyAppToolsRow>

    enum MyAppToolsSection: Int, CaseIterable {
        case tools
    }

    enum MyAppToolsRow: Hashable {
        case tool(index: Int)
    }

    private func configureDataSource() -> DataSource {
        let dataSource: DataSource = .init(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self else {
                return collectionView.dequeueReusableCell(
                    withType: UICollectionViewCell.self,
                    for: indexPath
                )
            }
            return self.cellProvider(
                collectionView: collectionView,
                indexPath: indexPath,
                item: itemIdentifier
            )
        }
        return dataSource
    }

    private func cellProvider(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: MyAppToolsRow
    ) -> UICollectionViewCell {
        switch item {
        case let .tool(index):
            let title = viewModel.items[getOrNil: index]?.title ?? ""
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: .init(title: title)
            )
            return cell
        }
    }

    private func setupDefaultSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(MyAppToolsSection.allCases)
        dataSource.apply(snapshot)
    }

    private func updateSnapshot(items: [MyAppToolsModel.ItemType]) {
        var snapshot = dataSource.snapshot()
        let currentRows = snapshot.itemIdentifiers(inSection: .tools)
        items
            .indices
            .map {
                MyAppToolsRow.tool(index: $0)
            }
            .forEach {
                if currentRows.contains($0) {
                    snapshot.reconfigureItems([$0])
                } else {
                    snapshot.appendItems([$0], toSection: .tools)
                }
            }

        let itemCount = items.count
        let itemCountDiff = currentRows.count - itemCount
        if itemCountDiff > 0 {
            let deleteTargets = (itemCount..<itemCount + itemCountDiff).map {
                MyAppToolsRow.tool(index: $0)
            }
            snapshot.deleteItems(deleteTargets)
        }

        dataSource.apply(snapshot)
    }
}

extension MyAppToolsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MyAppToolsViewController {
    struct CellItem {
        let title: String
    }
}
