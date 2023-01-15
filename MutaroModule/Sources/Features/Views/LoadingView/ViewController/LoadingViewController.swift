//
//  LoadingViewController.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import UIKit

class LoadingViewController: UIViewController {

    private let viewModel: LoadingViewModel

    init(viewModel: LoadingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.5)
    }
}
