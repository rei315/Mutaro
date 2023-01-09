//
//  SettingViewController.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

class SettingViewController: UIViewController {
    private lazy var collectionView: UICollectionView = .init(
        frame: .zero,
        collectionViewLayout: createLayout()
    )

    private lazy var dataSource:
        UICollectionViewDiffableDataSource<SettingListSection, SettingListRow> = .init(
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

    weak var coordinator: SettingCoordinator?
    private let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = HomeTabPage.setting.title
        
        setupCollectionView()
        setupDefaultSnapshot()
        setupSubscription()
        
#if DEV
        viewModel.setupDeveloperSettings()
#endif
    }
    
    private func setupSubscription() {
        viewModel.shouldAddDeveloperSettingSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.setupDevelopToolsSnapshot()
            }
            .store(in: &viewModel.cancellables)
    }
}

extension SettingViewController {
    private func setupCollectionView() {
        collectionView.lets {
            $0.backgroundColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.dataSource = dataSource
            $0.delegate = self
            $0.prefetchDataSource = self
            $0.registerClass(withType: SettingDefaultCollectionViewCell.self)
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
        snapshot.appendSections(SettingListSection.allCases)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupDevelopToolsSnapshot() {
        var snapshot = dataSource.snapshot()
        let devTool1 = SettingListRow.developSetting(0)
        snapshot.appendItems([devTool1], toSection: .developSetting)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else {
                return nil
            }
            let section = self.dataSource.sectionIdentifier(for: sectionIndex)
            switch section {
            case .setting:
                var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
                configuration.backgroundColor = .white
                let section = NSCollectionLayoutSection.list(
                    using: configuration,
                    layoutEnvironment: layoutEnvironment
                )
                return section
            case .developSetting:
                var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
                configuration.backgroundColor = .white
                let section = NSCollectionLayoutSection.list(
                    using: configuration,
                    layoutEnvironment: layoutEnvironment
                )
                return section
            case .none:
                return nil
            }
        }
    }
}

extension SettingViewController {
    enum SettingListSection: Hashable, CaseIterable {
        case setting
        case developSetting
    }
    
    enum SettingListRow: Hashable {
        case defaultSetting(Int)
        case developSetting(Int)
    }
    
    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: SettingListRow) -> UICollectionViewCell {
        switch item {
        case .defaultSetting:
            return collectionView.dequeueReusableCell(withType: SettingDefaultCollectionViewCell.self, for: indexPath)
        case .developSetting:
            return collectionView.dequeueReusableCell(withType: SettingDefaultCollectionViewCell.self, for: indexPath)
        }
    }
}

extension SettingViewController: UICollectionViewDelegate {
    
}

extension SettingViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}
