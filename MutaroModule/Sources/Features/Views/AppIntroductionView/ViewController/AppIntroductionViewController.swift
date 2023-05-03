//
//  AppIntroductionViewController.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

public final class AppIntroductionViewController: UIViewController {
    private let button: UIButton = .init()

    weak var delegate: AppIntroductDelegate?
    private var viewModel: AppIntroductionViewModel

    init(viewModel: AppIntroductionViewModel) {
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
                self?.delegate?.onTapAgree()
            }
            view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalToConstant: 100),
                $0.heightAnchor.constraint(equalToConstant: 50),
                $0.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
}
