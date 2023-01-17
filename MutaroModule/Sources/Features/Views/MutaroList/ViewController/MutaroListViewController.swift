//
//  MutaroListViewController.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import Core
import ImageLoader
import UIKit

public class MutaroListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: createLayout()
    )

    private lazy var dataSource:
        UICollectionViewDiffableDataSource<MutaroListSection, MutaroListRow> = .init(
            collectionView: collectionView
        ) {
            [weak self] (collectionView, indexPath, item) -> UICollectionViewCell in
            guard let self = self else {
                return UICollectionViewCell()
            }
            return self.cellProvider(
                collectionView: collectionView,
                indexPath: indexPath,
                item: item
            )
        }

    private let viewModel: MutaroListViewModel
    private var couldCardViewPaging: Bool = false

    init(viewModel: MutaroListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = HomeTabPage.mutaroList.title

        setupCollectionView()
        setupDefaultSnapshot()
        setupSubscription()

        Task {
            await viewModel.fetchMutaroItems()
        }
    }

    private func setupSubscription() {
        viewModel.$mutaroItems
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.updateSnapshot($0)
            }
            .store(in: &viewModel.cancellables)
    }
}

extension MutaroListViewController {
    private func setupCollectionView() {
        collectionView.lets {
            $0.backgroundColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.dataSource = dataSource
            $0.delegate = self
            $0.prefetchDataSource = self
            $0.registerClass(withType: MutaroListCirclePhotoCell.self)
            $0.registerClass(withType: MutaroListCardPhotoCell.self)
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else {
                return nil
            }
            let section = self.dataSource.sectionIdentifier(for: sectionIndex)
            switch section {
            case .mutaroHorizontalCirclePhotos:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .absolute(MutaroListCirclePhotoCell.imageSize),
                        heightDimension: .absolute(MutaroListCirclePhotoCell.imageSize)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

                return section
            case .mutaroHorizontalCardPhotos:
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .fractionalHeight(0.8)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

                return section
            case .mutaroInfo:
                return nil
            case .none:
                return nil
            }
        }
    }

    private func setupDefaultSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(MutaroListSection.allCases)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func updateSnapshot(_ items: [MutaroModel]) {
        var snapshot = dataSource.snapshot()

        let currentHorizontalCirclePhotosItems = snapshot.itemIdentifiers(
            inSection: .mutaroHorizontalCirclePhotos
        )
        items.indices.map {
            MutaroListRow.mutaroCirclePhoto(index: $0)
        }.forEach {
            if currentHorizontalCirclePhotosItems.contains($0) {
                snapshot.reconfigureItems([$0])
            } else {
                snapshot.appendItems([$0], toSection: .mutaroHorizontalCirclePhotos)
            }
        }

        let newHorizontalCirclePhotoItemsCount = items.count
        let horizontalCirclePhotoItemsDiff =
            currentHorizontalCirclePhotosItems.count - newHorizontalCirclePhotoItemsCount
        if horizontalCirclePhotoItemsDiff > 0 {
            let deleteTargets =
                (newHorizontalCirclePhotoItemsCount..<newHorizontalCirclePhotoItemsCount
                + horizontalCirclePhotoItemsDiff).map {
                    MutaroListRow.mutaroCirclePhoto(index: $0)
                }
            snapshot.deleteItems(deleteTargets)
        }

        let currentHorizontalCardPhotosItem = snapshot.itemIdentifiers(
            inSection: .mutaroHorizontalCardPhotos
        )
        items.indices.map {
            MutaroListRow.mutaroCardPhoto(index: $0)
        }.forEach {
            if currentHorizontalCardPhotosItem.contains($0) {
                snapshot.reconfigureItems([$0])
            } else {
                snapshot.appendItems([$0], toSection: .mutaroHorizontalCardPhotos)
            }
        }

        let newHorizontalCardPhotosItemCount = items.count
        let horizontalCardPhotoItemsDiff =
            currentHorizontalCardPhotosItem.count - newHorizontalCardPhotosItemCount
        if horizontalCardPhotoItemsDiff > 0 {
            let deleteTargets =
                (newHorizontalCardPhotosItemCount..<newHorizontalCardPhotosItemCount
                + horizontalCardPhotoItemsDiff).map {
                    MutaroListRow.mutaroCardPhoto(index: $0)
                }
            snapshot.deleteItems(deleteTargets)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension MutaroListViewController: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MutaroListViewController {
    enum MutaroListSection: Hashable, CaseIterable {
        case mutaroHorizontalCirclePhotos
        case mutaroHorizontalCardPhotos
        case mutaroInfo
    }

    enum MutaroListRow: Hashable {
        case mutaroCirclePhoto(index: Int)
        case mutaroCardPhoto(index: Int)
        case mutaroInfo
    }

    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: MutaroListRow)
        -> UICollectionViewCell
    {
        switch item {
        case let .mutaroCirclePhoto(index):
            let cell = collectionView.dequeueReusableCell(
                withType: MutaroListCirclePhotoCell.self, for: indexPath)
            cell.resetCell()

            if let imageUrl = viewModel.mutaroItems[getOrNil: index]?.imageUrl {
                cell.configureCell(imageUrl)
            }
            return cell
        case let .mutaroCardPhoto(index):
            let cell = collectionView.dequeueReusableCell(
                withType: MutaroListCardPhotoCell.self, for: indexPath)
            cell.resetCell()
            if let imageUrl = viewModel.mutaroItems[getOrNil: index]?.imageUrl {
                cell.configureCell(imageUrl)
            }
            return cell
        case .mutaroInfo:
            return UICollectionViewCell()
        }
    }
}

extension MutaroListViewController: UICollectionViewDataSourcePrefetching {
    public func collectionView(
        _ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]
    ) {
        indexPaths.forEach {
            let item = dataSource.itemIdentifier(for: $0)
            switch item {
            case let .mutaroCirclePhoto(index), let .mutaroCardPhoto(index):
                viewModel.prefetchHorizontalSectionItem(row: index)
            case .mutaroInfo:
                break
            case .none:
                break
            }
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]
    ) {
        indexPaths.forEach {
            let item = dataSource.itemIdentifier(for: $0)
            switch item {
            case let .mutaroCirclePhoto(index), let .mutaroCardPhoto(index):
                viewModel.cancelPrefetchHorizontalSectionItem(row: index)
            case .mutaroInfo:
                break
            case .none:
                break
            }
        }
    }
}
