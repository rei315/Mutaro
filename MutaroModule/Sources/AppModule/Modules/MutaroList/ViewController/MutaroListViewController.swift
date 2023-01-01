//
//  MutaroListViewController.swift
//
//
//  Created by minguk-kim on 2022/12/29.
//

import UIKit

public class MutaroListViewController: UIViewController {
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        let fraction: CGFloat = 1 / 3

        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        // Section
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }()

    private lazy var collectionView: UICollectionView = .init(
        frame: .zero, collectionViewLayout: compositionalLayout)

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
        navigationItem.title = "mutaro"
        setupCollectionView()
        setupDefaultSnapshot()
        setupSubscription()
    }

    private func setupSubscription() {
        viewModel.mutaroItems
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
            $0.registerClass(withType: MutaroListCollectionViewCell.self)
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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

    private func updateSnapshot(_ items: [String]) {
        var snapshot = dataSource.snapshot()
        let mutaroRows: [MutaroListRow] = items.indices.map {
            MutaroListRow.mutaroPhoto(index: $0)
        }
        snapshot.appendItems(mutaroRows, toSection: .mutaroPhotos)
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
        case mutaroInfo
        case mutaroPhotos
    }

    enum MutaroListRow: Hashable {
        case mutaroInfo
        case mutaroPhoto(index: Int)
    }

    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: MutaroListRow)
        -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(
            withType: MutaroListCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .blue.withAlphaComponent(0.2)
        return cell
    }
}
