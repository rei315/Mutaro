//
//  RegisterJWTViewController.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import AppResource
import Core
import UIKit

class RegisterJWTViewController: UIViewController {
    private let stackView: UIStackView = .init()

    private let issuerIDTitleLabel: UILabel = .init()
    private let issuerIDTextView: PaddingTextField = .init()

    private let keyIDTitleLabel: UILabel = .init()
    private let keyIDTextView: PaddingTextField = .init()

    private let privateKeyTitleLabel: UILabel = .init()
    private let privateKeyTextView: PlaceholderTextView = .init(padding: 12)

    private let viewModel: RegisterJWTViewModel

    init(viewModel: RegisterJWTViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "JWT生成"
        setupView()
        setupRegisterButton()
        setupSubcription()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSmallTitle()
    }

    private func setupSubcription() {
        viewModel.showAlertSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showAlert(state: $0)
            }
            .store(in: &viewModel.cancellables)
    }

    private func setupView() {
        stackView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.addArrangedSubview(issuerIDTitleLabel)
            $0.addArrangedSubview(issuerIDTextView)
            $0.setCustomSpacing(20, after: issuerIDTextView)

            $0.addArrangedSubview(keyIDTitleLabel)
            $0.addArrangedSubview(keyIDTextView)
            $0.setCustomSpacing(20, after: keyIDTextView)

            $0.addArrangedSubview(privateKeyTitleLabel)
            $0.addArrangedSubview(privateKeyTextView)

            $0.addArrangedSubview(.createSpacer(axis: .vertical))
            $0.axis = .vertical
            $0.spacing = 12

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        }

        issuerIDTitleLabel.lets {
            $0.text = "Issuer ID"
            $0.font = FontSize.minus1.ofBoldFont()
            $0.textColor = Resources.Colors.navy70.color
        }
        issuerIDTextView.lets {
            $0.textPadding = .init(top: 12, left: 12, bottom: 12, right: 12)
            $0.placeholder = "Issuer IDを入力してください"
            $0.font = FontSize.minus1.ofFont()
            $0.textColor = Resources.Colors.navy40.color
            $0.layer.borderColor = Resources.Colors.navy20.color.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        keyIDTitleLabel.lets {
            $0.text = "Key ID"
            $0.font = FontSize.minus1.ofBoldFont()
            $0.textColor = Resources.Colors.navy70.color
        }
        keyIDTextView.lets {
            $0.textPadding = .init(top: 12, left: 12, bottom: 12, right: 12)
            $0.placeholder = "Key IDを入力してください"
            $0.font = FontSize.minus1.ofFont()
            $0.textColor = Resources.Colors.navy40.color
            $0.layer.borderColor = Resources.Colors.navy20.color.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
        }

        privateKeyTitleLabel.lets {
            $0.text = "Private Key"
            $0.font = FontSize.minus1.ofBoldFont()
            $0.textColor = Resources.Colors.navy70.color
        }
        privateKeyTextView.lets {
            $0.font = FontSize.minus1.ofBoldFont()
            $0.textColor = Resources.Colors.navy70.color
            $0.layer.borderColor = Resources.Colors.navy20.color.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.placeholder = "PrivateKeyを入力してください"
        }
    }

    private func setupRegisterButton() {
        navigationItem.rightBarButtonItem = .init(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(onTapRegister)
        )
    }

    @objc
    private func onTapRegister() {
        let issuerID = issuerIDTextView.text
        let keyID = keyIDTextView.text
        let privateKey = privateKeyTextView.text

        viewModel.onTapRegister(
            issuerID: issuerID,
            keyID: keyID,
            privateKey: privateKey
        )
    }

    private func showAlert(state: RegisterJWTViewModel.AlertState) {
        AlertHUD.show(title: state.title)
    }
}
