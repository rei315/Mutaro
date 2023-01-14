//
//  MutaroInfoUploadViewController.swift
//
//
//  Created by minguk-kim on 2023/01/12.
//

import AppResource
import Core
import ImageLoader
import PhotosUI
import UIKit

final public class MutaroInfoUploadViewController: UIViewController {

    private let imageView: UIButton = .init()

    private let titleLabel: UILabel = .init()
    private let titleLimitLabel: UILabel = .init()
    private let titleField: PaddingTextField = .init()

    private let descriptionLabel: UILabel = .init()
    private let descriptionLimitLabel: UILabel = .init()
    private let descriptionField: UITextView = .init()

    private let viewModel: MutaroInfoUploadViewModel
    private var isShowingKeyboard: Bool = false

    enum TextFieldCharacterLimit: Int {
        case title = 20
        case description = 100
    }

    public init(viewModel: MutaroInfoUploadViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSubscription()
        setupNotificationCenter()
        setupNavigationBarItem()
    }

    private func setupNavigationBarItem() {
        let postButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(showPostAlert)
        )
        navigationItem.rightBarButtonItem = postButton
    }

    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }

    private func setupView() {
        setSmallTitle()
        title = "むの情報をアップロード"
        view.backgroundColor = .white

        let imageHorizontalPadding: CGFloat = 40
        let imageViewRadius: CGFloat = 10

        imageView.lets {
            $0.imageView?.contentMode = .scaleAspectFill
            $0.imageView?.clipsToBounds = true
            $0.imageView?.layer.cornerRadius = imageViewRadius
            $0.setImage(UIImage(systemName: "photo"), for: .normal)
            $0.layer.cornerRadius = imageViewRadius
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = Resources.Colors.navy20.color
            $0.updateAction(.touchUpInside) { [weak self] in
                self?.openPhotoPicker()
            }
            view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                $0.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor, constant: imageHorizontalPadding),
                $0.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor, constant: -imageHorizontalPadding),
                $0.heightAnchor.constraint(equalTo: $0.widthAnchor, multiplier: 1.0),
            ])
        }

        titleLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = FontSize.base.ofBoldFont()
            $0.textColor = Resources.Colors.navy.color
            $0.text = "画像のタイトル"
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28),
                $0.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            ])
        }

        titleLimitLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = FontSize.minus2.ofFont()
            $0.textColor = Resources.Colors.wine.color
        }
        updateTitleLimit(0)

        titleField.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 8
            $0.backgroundColor = Resources.Colors.navy10.color
            $0.placeholder = "タイトルを入力してください..."
            $0.textPadding = .init(top: 0, left: 12, bottom: 0, right: 12)
            $0.font = FontSize.minus1.ofFont()
            $0.textColor = Resources.Colors.navy40.color
            $0.delegate = self
            $0.addSubview(titleLimitLabel)
            view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
                $0.heightAnchor.constraint(equalToConstant: 40),

                titleLimitLabel.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: -8),
                titleLimitLabel.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: -4),
            ])
        }

        descriptionLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = FontSize.base.ofBoldFont()
            $0.textColor = Resources.Colors.navy.color
            $0.text = "画像の説明"
            view.addSubview($0)
            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 16),
                $0.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            ])
        }
        descriptionLimitLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = FontSize.minus2.ofFont()
            $0.textColor = Resources.Colors.wine.color
            view.addSubview($0)
        }
        updateDescriptionLimit(0)

        descriptionField.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.layer.cornerRadius = 8
            $0.backgroundColor = Resources.Colors.navy10.color
            $0.textContainerInset = .init(top: 12, left: 12, bottom: 12, right: 12)
            $0.font = FontSize.minus1.ofFont()
            $0.textColor = Resources.Colors.navy40.color
            $0.delegate = self
            view.addSubview($0)

            NSLayoutConstraint.activate([
                $0.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
                $0.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
                $0.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
                $0.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),

                descriptionLimitLabel.trailingAnchor.constraint(
                    equalTo: $0.trailingAnchor, constant: -8),
                descriptionLimitLabel.bottomAnchor.constraint(
                    equalTo: $0.bottomAnchor, constant: -4),
            ])
        }
        view.bringSubviewToFront(descriptionLimitLabel)
    }

    private func setupSubscription() {
        viewModel.$pickedPhotoData
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] in
                guard let self else {
                    return
                }
                self.updateImageView(url: $0.url)
            }
            .store(in: &viewModel.cancellables)

        viewModel.didFinishedPostMutaroInfo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else {
                    return
                }
                self.showFinishedPostAlert()
            }
            .store(in: &viewModel.cancellables)
    }
}

extension MutaroInfoUploadViewController {
    @objc
    private func showPostAlert() {
        let alert = UIAlertController(
            title: "情報アップロード",
            message: "入力した情報でサーバーにアップロードしますか？",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(
            title: "キャンセル",
            style: .cancel
        )
        let postAction = UIAlertAction(
            title: "保存",
            style: .default
        ) { [weak self] _ in
            self?.postButtonHandler()
        }

        alert.addAction(cancelAction)
        alert.addAction(postAction)
        self.present(alert, animated: true)
    }

    private func showFinishedPostAlert() {
        let alert = UIAlertController(
            title: "アップロード完了",
            message: "情報をFirebaseにアップロードしました。",
            preferredStyle: .alert
        )
        let doneAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { [weak self] _ in
            self?.viewModel.dismiss()
        }

        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
}

extension MutaroInfoUploadViewController {
    private func postButtonHandler() {
        Task {
            await viewModel.onTapPost(
                title: titleField.text,
                description: descriptionField.text
            )
        }
    }
}

extension MutaroInfoUploadViewController {
    private func updateTitleLimit(_ count: Int) {
        titleLimitLabel.text = "(\(count)/\(TextFieldCharacterLimit.title.rawValue))"
    }

    private func updateDescriptionLimit(_ count: Int) {
        descriptionLimitLabel.text = "(\(count)/\(TextFieldCharacterLimit.description.rawValue))"
    }

    private func updateImageView(url: URL) {
        guard let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
        else {
            return
        }
        let resizedImage = image.downsample(imageAt: url, to: self.imageView.frame.size)
        self.imageView.setImage(resizedImage, for: .normal)
    }
}

extension MutaroInfoUploadViewController {
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard !isShowingKeyboard else {
            return
        }
        isShowingKeyboard = true

        guard
            let keyboardSize =
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
                .cgRectValue,
            let keyboardDuration =
                (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? NSNumber)?.doubleValue
        else {
            return
        }
        let tabBarHeight = tabBarController?.tabBar.bounds.size.height ?? 0
        let bottomHeight = keyboardSize.height - tabBarHeight

        Task { @MainActor in
            UIView.animate(withDuration: keyboardDuration) {
                self.view.frame.origin.y = -bottomHeight
            }
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        guard isShowingKeyboard else {
            return
        }
        isShowingKeyboard = false

        guard
            let keyboardDuration =
                (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
                as? NSNumber)?.doubleValue
        else {
            return
        }

        Task { @MainActor in
            UIView.animate(withDuration: keyboardDuration) {
                self.view.frame.origin.y = 0
            }
        }
    }
}

extension MutaroInfoUploadViewController {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard let touch = touches.first else {
            return
        }

        switch touch.view {
        case titleField, descriptionField:
            break
        default:
            self.view.endEditing(true)
        }
    }
}

extension MutaroInfoUploadViewController: PHPickerViewControllerDelegate {
    private func openPhotoPicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        configuration.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        picker.modalPresentationStyle = .popover
        present(picker, animated: true)
    }

    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult])
    {
        picker.dismiss(animated: true)
        Task {
            await viewModel.didFinishedPickedPhoto(results: results)
        }
    }
}

extension MutaroInfoUploadViewController: UITextFieldDelegate {
    public func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let charactersLimit: Int

        switch textField {
        case titleField:
            charactersLimit = TextFieldCharacterLimit.title.rawValue
        default:
            charactersLimit = 0
        }

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

        let changedText = currentText.replacingCharacters(in: stringRange, with: string)

        let isNotOverLimit = changedText.count <= charactersLimit

        if isNotOverLimit {
            switch textField {
            case titleField:
                updateTitleLimit(changedText.count)
            default:
                break
            }
        }

        return isNotOverLimit
    }
}

extension MutaroInfoUploadViewController: UITextViewDelegate {
    public func textView(
        _ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String
    ) -> Bool {
        let charactersLimit: Int

        switch textView {
        case descriptionField:
            charactersLimit = TextFieldCharacterLimit.description.rawValue
        default:
            charactersLimit = 0
        }

        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

        let changedText = currentText.replacingCharacters(in: stringRange, with: text)

        let isNotOverLimit = changedText.count <= charactersLimit

        if isNotOverLimit {
            switch textView {
            case descriptionField:
                updateDescriptionLimit(changedText.count)
            default:
                break
            }
        }

        return isNotOverLimit
    }
}
