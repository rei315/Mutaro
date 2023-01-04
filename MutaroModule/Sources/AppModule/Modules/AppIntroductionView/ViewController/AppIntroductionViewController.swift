//
//  AppIntroductionViewController.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import CommonAppModule
import UIKit

class AppIntroductionViewController: UIViewController {
    private let button: UIButton = .init()

    weak var coordinator: AppIntroductionCoordinator?
    private var viewModel = AppIntroductionViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        var attributedString = AttributedString("Hello Tap")
        attributedString.foregroundColor = .black
        attributedString.font = .systemFont(ofSize: 14)

        button.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.titleLabel?.font = .systemFont(ofSize: 16)

            var configuration = UIButton.Configuration.filled()
            configuration.background.cornerRadius = 5
            configuration.background.backgroundColor = .green.withAlphaComponent(0.2)

            configuration.attributedTitle = attributedString

            $0.configuration = configuration
            $0.updateAction(.touchUpInside) { [weak self] in
                self?.viewModel.onTapAgree()
                self?.coordinator?.onTapAgree()
            }
            view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: 100),
                $0.heightAnchor.constraint(equalToConstant: 50),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }
    }
}
