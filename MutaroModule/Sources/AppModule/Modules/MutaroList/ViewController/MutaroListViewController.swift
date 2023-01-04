//
//  MutaroListViewController.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import ImageModule
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

    weak var coordinator: MutaroListCoordinator?
    private let viewModel = MutaroListViewModel()

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = HomeTabPage.mutaroList.title

        setupCollectionView()
        setupDefaultSnapshot()
        setupSubscription()

        viewModel.fetchMutaroItems()
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

    private func updateSnapshot(_ items: [Int]) {
        var snapshot = dataSource.snapshot()
        let mutaroRows: [MutaroListRow] = items.indices.map {
            MutaroListRow.mutaroHorizontalPhoto(index: $0)
        }
        snapshot.appendItems(mutaroRows, toSection: .mutaroHorizontalPhotos)
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
            if let image = ImageContentPathProvider.ContentFileType(rawValue: index) {
                cell.configureCell(imageType: image)
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
