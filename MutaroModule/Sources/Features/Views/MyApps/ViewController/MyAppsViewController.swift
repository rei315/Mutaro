//
//  MyAppsViewController.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Core
import ImageLoader
import JWTGenerator
import UIKit

public class MyAppsViewController: UIViewController {
    private lazy var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: configureLayout())
    private lazy var dataSource: DataSource = self.configureDataSource()
    private let viewModel: MyAppsViewModel

    init(viewModel: MyAppsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = HomeTabPage.myApps.title

        setupView()
        setupSubscription()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadStoredJWTInfo()
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

    private func setupSubscription() {
        viewModel.currentJWTInfoSubject
            .removeDuplicates()
            .compactMap { $0 }
            .sink { [weak self] in
                self?.fetchMyApps(storedJWTInfo: $0)
            }
            .store(in: &viewModel.cancellables)

        viewModel.appInfosSubject
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.updateAppsSnapshot(items: $0)
            }
            .store(in: &viewModel.cancellables)
    }

    private func fetchMyApps(storedJWTInfo: MutaroJWT.JWTRequestInfo) {
        Task {
            await viewModel.fetchMyApps(storedJWTInfo: storedJWTInfo)
        }
    }
}

extension MyAppsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MyAppsViewController: UICollectionViewDataSourcePrefetching {
    public func collectionView(_: UICollectionView, prefetchItemsAt _: [IndexPath]) {}

    public func collectionView(_: UICollectionView, cancelPrefetchingForItemsAt _: [IndexPath]) {}
}

extension MyAppsViewController {
    private func configureLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else {
                return nil
            }
            let section = self.dataSource.sectionIdentifier(for: sectionIndex)
            switch section {
            case .registerJWT:
                return nil
            case .app:
                return nil
            case .none:
                return nil
            }
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

    private func updateAppsSnapshot(items: [MyAppsViewModel.AppInfo]) {
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

    private func configureDataSource() -> DataSource {
        let dataSource: DataSource = .init(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, item in
            guard let self else {
                return UICollectionViewCell()
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
            )
            cell.bind(url: "")

            return cell
        case .registerJWT:
            let cell = collectionView.dequeueReusableCell(
                withType: MyAppsRegisterJWTCell.self,
                for: indexPath
            )
            return cell
        }
    }
}
