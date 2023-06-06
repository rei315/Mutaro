//
//  MyAppToolsViewController.swift
//
//
//  Created by minguk-kim on 2023/06/07.
//

import UIKit

final class MyAppToolsViewController: UIViewController {
    private let viewModel: MyAppToolsViewModel
    private let dependency: Dependency

    public struct Dependency {
        let viewModel: MyAppToolsViewModel

        public init(viewModel: MyAppToolsViewModel) {
            self.viewModel = viewModel
        }
    }

    public init(dependency: Dependency) {
        self.dependency = dependency
        viewModel = dependency.viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
