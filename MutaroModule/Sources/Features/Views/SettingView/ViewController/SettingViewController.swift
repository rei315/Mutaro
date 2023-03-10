//
//  SettingViewController.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import AppResource
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

    private let viewModel: SettingViewModel

    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        let settings: [SettingType] = [.info, .setting]
        let rowItems: [SettingListRow] = settings.indices.map {
            SettingListRow.defaultSetting($0)
        }
        snapshot.appendItems(rowItems, toSection: .setting)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func setupDevelopToolsSnapshot() {
        var snapshot = dataSource.snapshot()
        let tools: [DevSettingType] = [.devToolDataUploader]
        let rowItems: [SettingListRow] = tools.indices.map {
            SettingListRow.developSetting($0)
        }
        snapshot.appendItems(rowItems, toSection: .developSetting)
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

    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: SettingListRow)
        -> UICollectionViewCell
    {
        switch item {
        case let .defaultSetting(index):
            return collectionView.dequeueReusableCell(
                withType: SettingDefaultCollectionViewCell.self,
                for: indexPath
            ).apply {
                guard let type = SettingType(rawValue: index) else {
                    return
                }

                $0.bind(type: type)
            }
        case let .developSetting(index):
            return collectionView.dequeueReusableCell(
                withType: SettingDefaultCollectionViewCell.self,
                for: indexPath
            ).apply {
                guard let type = DevSettingType(rawValue: index) else {
                    return
                }

                $0.bind(type: type)
            }
        }
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        switch item {
        case let .defaultSetting(index):
            break
        case let .developSetting(index):
            switch DevSettingType(rawValue: index) {
            case .devToolDataUploader:
                viewModel.onTapDevToolUploadMutaroInfo()
            case .none:
                break
            }
        case .none:
            break
        }
    }
}

extension SettingViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath])
    {

    }
}

extension SettingViewController {
    enum SettingType: Int {
        case info
        case setting

        var title: String {
            switch self {
            case .info:
                return "?????????????????????"
            case .setting:
                return "??????"
            }
        }

        var icon: UIImage {
            let asset: ImageAsset
            switch self {
            case .info:
                asset = Resources.Images.info
            case .setting:
                asset = Resources.Images.setting
            }
            return asset.image
        }
    }

    enum DevSettingType: Int {
        case devToolDataUploader

        var title: String {
            switch self {
            case .devToolDataUploader:
                return "???????????????"
            }
        }

        var icon: UIImage {
            let asset: ImageAsset
            switch self {
            case .devToolDataUploader:
                asset = Resources.Images.devSetting
            }
            return asset.image
        }
    }
}
