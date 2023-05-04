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

        setupSubscription()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadStoredJWTInfo()
    }

    private func setupSubscription() {
        viewModel.currentJWTInfo
            .compactMap { $0 }
            .sink { [weak self] in
                self?.fetchMyApps(storedJWTInfo: $0)
            }
            .store(in: &viewModel.cancellables)
    }

    private func fetchMyApps(storedJWTInfo: MutaroJWT.JWTRequestInfo) {
        Task {
            let infos = await viewModel.fetchMyApps(storedJWTInfo: storedJWTInfo)
        }
    }
}
