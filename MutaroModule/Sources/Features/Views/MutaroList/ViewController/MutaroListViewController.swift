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

    init(viewModel: MutaroListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await viewModel.fetchMutaroItems()
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = HomeTabPage.mutaroList.title

        setupCollectionView()
        setupDefaultSnapshot()
        setupSubscription()
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
            $0.registerClass(withType: MutaroListHorizontalPhotoCell.self)
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
        }
    }

    private func setupDefaultSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(MutaroListSection.allCases)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func updateSnapshot(_ items: [MutaroModel]) {
        var snapshot = dataSource.snapshot()

        let currentHorizontalPhotosItems = snapshot.itemIdentifiers(
            inSection: .mutaroHorizontalPhotos)
        items.indices.map {
            MutaroListRow.mutaroHorizontalPhoto(index: $0)
        }.forEach {
            if currentHorizontalPhotosItems.contains($0) {
                snapshot.reconfigureItems([$0])
            } else {
                snapshot.appendItems([$0], toSection: .mutaroHorizontalPhotos)
            }
        }

        let newHorizontalPhotoItemsCount = items.count
        let horizontalPhotoItemsDiff =
            currentHorizontalPhotosItems.count - newHorizontalPhotoItemsCount
        if horizontalPhotoItemsDiff > 0 {
            let delegateTargets =
                (newHorizontalPhotoItemsCount..<newHorizontalPhotoItemsCount
                + horizontalPhotoItemsDiff).map {
                    MutaroListRow.mutaroHorizontalPhoto(index: $0)
                }
            snapshot.deleteItems(delegateTargets)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else {
                return nil
            }
            let section = self.dataSource.sectionIdentifier(for: sectionIndex)
            switch section {
            case .mutaroHorizontalPhotos:
                let fraction: CGFloat = 1 / 5
                let item = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(fraction),
                        heightDimension: .fractionalWidth(fraction)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 10
                section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

                return section
            case .mutaroInfo:
                return nil
            case .mutaroVerticalPhotos:
                return nil
            case .none:
                return nil
            }
        }
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
        case mutaroHorizontalPhotos
        case mutaroInfo
        case mutaroVerticalPhotos
    }

    enum MutaroListRow: Hashable {
        case mutaroHorizontalPhoto(index: Int)
        case mutaroInfo
        case mutaroPhoto(index: Int)
    }

    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: MutaroListRow)
        -> UICollectionViewCell
    {
        switch item {
        case let .mutaroHorizontalPhoto(index):
            let cell = collectionView.dequeueReusableCell(
                withType: MutaroListHorizontalPhotoCell.self, for: indexPath)
            if let detail = viewModel.mutaroItems[getOrNil: index] {
                cell.configureCell(mutaroDetail: detail)
            }
            return cell
        case .mutaroInfo:
            return UICollectionViewCell()
        case let .mutaroPhoto(index):
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
            case let .mutaroHorizontalPhoto(index):
                viewModel.prefetchHorizontalSectionItem(row: index)
                break
            case .mutaroInfo:
                break
            case let .mutaroPhoto(index):
                break
            case .none:
                break
            }
        }
    }
}
