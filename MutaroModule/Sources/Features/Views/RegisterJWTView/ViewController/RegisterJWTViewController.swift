//
//  RegisterJWTViewController.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import UIKit

class RegisterJWTViewController: UIViewController {
    private let viewModel: RegisterJWTViewModel

    init(viewModel: RegisterJWTViewModel) {
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
        title = "JWT生成"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSmallTitle()
    }
}
