//
//  RegisterJWTViewController.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import AppResource
import Core
import JWTGenerator
import UIKit
import UniformTypeIdentifiers

class RegisterJWTViewController: UIViewController {
    private let scrollView: UIScrollView = .init()
    private let stackView: UIStackView = .init()

    private let issuerIDTitleLabel: UILabel = .init()
    private let issuerIDTextView: PaddingTextField = .init()

    private let keyIDTitleLabel: UILabel = .init()
    private let keyIDTextView: PaddingTextField = .init()

    private let privateKeyTitleLabel: UILabel = .init()
    private let privateKeyTextView: PlaceholderTextView = .init(padding: 12)

    private let selectFileButton: UIButton = .init(type: .system)

    private let viewModel: RegisterJWTViewModel

    private var keyboardHeightConstraint: NSLayoutConstraint?

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
        setupNotification()
        viewModel.loadRegisteredInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setSmallTitle()
    }

    private func setupNotification() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main
        ) { [weak self] in
            self?.handleKeyboardState($0)
        }
    }

    private func setupSubcription() {
        viewModel.showAlertSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showAlert(state: $0)
            }
            .store(in: &viewModel.cancellables)

        viewModel.showSavedInfoSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.configureInfoTextViews(info: $0)
            }
            .store(in: &viewModel.cancellables)

        viewModel.didPickPrivateKeyFileSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.configurePrivateKeyTextViews(value: $0)
            }
            .store(in: &viewModel.cancellables)
    }

    private func setupView() {
        scrollView.lets {
            $0.showsVerticalScrollIndicator = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        }

        let scrollSpacer = UIView().apply {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 0).apply {
                    self.keyboardHeightConstraint = $0
                }
            ])
        }

        stackView.lets {
            scrollView.addSubview($0)
            $0.addArrangedSubview(.createSpacer(axis: .vertical, padding: 48))
            $0.addArrangedSubview(issuerIDTitleLabel)
            $0.addArrangedSubview(issuerIDTextView)
            $0.setCustomSpacing(20, after: issuerIDTextView)

            $0.addArrangedSubview(keyIDTitleLabel)
            $0.addArrangedSubview(keyIDTextView)
            $0.setCustomSpacing(20, after: keyIDTextView)

            $0.addArrangedSubview(privateKeyTitleLabel)
            $0.addArrangedSubview(privateKeyTextView)
            $0.addArrangedSubview(selectFileButton)
            $0.addArrangedSubview(.createSpacer(axis: .vertical))
            $0.addArrangedSubview(scrollSpacer)
            $0.axis = .vertical
            $0.spacing = 12

            $0.fillConstraint(to: scrollView)
            NSLayoutConstraint.activate([
                $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
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
            $0.clearButtonMode = .always
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
            $0.clearButtonMode = .always
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
            $0.placeholder = "PrivateKeyを入力するか、下のボタンからp8ファイルを選択してください。"
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 200)
            ])
        }

        selectFileButton.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitle("File Appからp8ファイルを選択する", for: .normal)
            $0.updateAction(.touchUpInside) { [weak self] in
                self?.showDocumentPicker()
            }
            NSLayoutConstraint.activate([
                $0.heightAnchor.constraint(equalToConstant: 60)
            ])
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

    private func configureInfoTextViews(info: MutaroJWT.JWTRequestInfo) {
        issuerIDTextView.text = info.issuerID
        keyIDTextView.text = info.keyID
        privateKeyTextView.text = info.privateKey
    }

    private func configurePrivateKeyTextViews(value: String) {
        privateKeyTextView.text = value
    }

    private func showDocumentPicker() {
        guard let p8Type = UTType(filenameExtension: "p8") else {
            return
        }
        let documentPicker = UIDocumentPickerViewController(
            forOpeningContentTypes: [
                p8Type
            ],
            asCopy: true
        )
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true)
    }
}

extension RegisterJWTViewController: UIDocumentPickerDelegate {
    public func documentPicker(_: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        viewModel.didPickDocuments(urls: urls)
    }
}

extension RegisterJWTViewController {
    private struct Info {
        let frame: CGRect
        let duration: Double
        let animationOptions: UIView.AnimationOptions
    }

    private func handleKeyboardState(_ notification: Notification) {
        guard let info = convertKeyboardInfo(notification) else {
            return
        }
        let isHiding = info.frame.origin.y == UIScreen.main.bounds.height
        keyboardHeightConstraint?.constant = isHiding ? 0 : info.frame.height
        UIView.animate(
            withDuration: info.duration,
            delay: 0,
            options: info.animationOptions
        ) {
            self.scrollView.layoutIfNeeded()
            self.moveTextFieldIfNeeded(info: info)
        }
    }

    private func convertKeyboardInfo(_ notification: Notification) -> Info? {
        guard let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let raw = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else {
            return nil
        }

        return Info(
            frame: frameValue.cgRectValue,
            duration: duration.doubleValue,
            animationOptions: UIView.AnimationOptions(rawValue: raw.uintValue)
        )
    }

    private func moveTextFieldIfNeeded(info: Info) {
        guard let input = stackView.arrangedSubviews
            .first(where: {
                switch $0 {
                case is UITextView:
                    return $0.isFirstResponder
                case is UITextField:
                    return $0.isFirstResponder
                default:
                    return false
                }
            }) else {
            return
        }

        let inputFrame = input.convert(input.bounds, to: nil)
        if inputFrame.intersects(info.frame) {
            scrollView.setContentOffset(CGPoint(x: 0, y: inputFrame.height), animated: true)
        } else {
            scrollView.setContentOffset(.zero, animated: true)
        }
    }
}
