//
//  MyAppToolsViewController.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import UIKit

final class MyAppToolsViewController: UIViewController {
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: configureLayout()
    )
    private lazy var dataSource: DataSource = configureDataSource()

    private let viewModel: MyAppToolsViewModel
    private let dependency: Dependency

    private let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CellItem> { cell, _, _ in
        var configuration = cell.myAppToolCellConfiguration()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        collectionView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.fillConstraint(to: view)
        }
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
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: .init(title: "test \(index)")
            )
            return cell
        }
    }
}

extension MyAppToolsViewController {
    struct CellItem {
        let title: String
    }
}
