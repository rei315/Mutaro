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
            [weak self] collectionView, indexPath, item -> UICollectionViewCell in
            guard let self else {
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

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = HomeTabPage.setting.title

        setupCollectionView()
        setupDefaultSnapshot()
    }
}

extension SettingViewController {
    private func setupCollectionView() {
        collectionView.lets {
            $0.backgroundColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.dataSource = dataSource
            $0.delegate = self
            $0.registerClass(withType: SettingDefaultCollectionViewCell.self)
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }

    private func setupDefaultSnapshot() {
        var snapshot = dataSource.snapshot()
        snapshot.appendSections(SettingListSection.allCases)
        let appSettings: [AppSettingType] = [.info, .setting]
        let settingsRowItems: [SettingListRow] = [.registerJWT]
        let appSettingsRowItems: [SettingListRow] = appSettings.indices.map {
            SettingListRow.defaultSetting($0)
        }
        snapshot.appendItems(settingsRowItems, toSection: .setting)
        snapshot.appendItems(appSettingsRowItems, toSection: .appSetting)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self else {
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
            case .appSetting:
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
        case appSetting
    }

    enum SettingListRow: Hashable {
        case registerJWT
        case defaultSetting(Int)
    }

    func cellProvider(collectionView: UICollectionView, indexPath: IndexPath, item: SettingListRow)
        -> UICollectionViewCell {
        switch item {
        case let .defaultSetting(index):
            return collectionView.dequeueReusableCell(
                withType: SettingDefaultCollectionViewCell.self,
                for: indexPath
            ).apply {
                guard let type = AppSettingType(rawValue: index) else {
                    return
                }

                $0.bind(type: type)
            }
        case .registerJWT:
            return collectionView.dequeueReusableCell(
                withType: SettingDefaultCollectionViewCell.self,
                for: indexPath
            ).apply {
                $0.bind(type: .registerJWT)
            }
        }
    }
}

extension SettingViewController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
        switch item {
        case let .defaultSetting(index):
            break
        case .registerJWT:
            viewModel.routeToRegisterJWT()
        case .none:
            break
        }
    }
}

extension SettingViewController {
    enum SettingType: Int {
        case registerJWT

        var title: String {
            switch self {
            case .registerJWT:
                return "登録する"
            }
        }

        var icon: UIImage? {
            switch self {
            case .registerJWT:
                return R.image.dev_setting()
            }
        }
    }

    enum AppSettingType: Int {
        case info
        case setting

        var title: String {
            switch self {
            case .info:
                return "アプリについて"
            case .setting:
                return "設定"
            }
        }

        var icon: UIImage? {
            switch self {
            case .info:
                return R.image.info()
            case .setting:
                return R.image.setting()
            }
        }
    }
}
