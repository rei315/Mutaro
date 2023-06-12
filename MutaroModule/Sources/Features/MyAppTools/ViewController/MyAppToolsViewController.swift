//
//  MyAppToolsViewController.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import Combine
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
        configuration.icon = item.icon
        cell.contentConfiguration = configuration
    }

    public struct Dependency {
        let viewModel: MyAppToolsViewModel

        public init(viewModel: MyAppToolsViewModel) {
            self.viewModel = viewModel
        }
    }

    private let viewDidLoadSubject: PassthroughSubject<Void, Never> = .init()
    private let didTapItemSubject: PassthroughSubject<MyAppToolsModel.ItemType, Never> = .init()
    
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
        bind()

        viewDidLoadSubject.send()
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

    private func bind() {
        let output = viewModel.transform(
            input: .init(
                viewDidLoad: viewDidLoadSubject.eraseToAnyPublisher(),
                didTapItem: didTapItemSubject.eraseToAnyPublisher()
            )
        )

        output
            .onUpdateItems
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
        case tool(item: MyAppToolsModel.ItemType)
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
        case let .tool(item):
            let title = item.title
            let icon = item.icon
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: .init(title: title, icon: icon)
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
        let rowItems = items.map { MyAppToolsRow.tool(item: $0) }
        let deleteTargets = currentRows.filter { !rowItems.contains($0) }

        snapshot.appendItems(rowItems)
        snapshot.deleteItems(deleteTargets)
        dataSource.apply(snapshot)
    }
}

extension MyAppToolsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let item = dataSource.itemIdentifier(for: indexPath)
        switch item {
        case let .tool(type):
            didTapItemSubject.send(type)
        case .none:
            break
        }
    }
}

extension MyAppToolsViewController {
    struct CellItem {
        let title: String
        let icon: UIImage?
    }
}
