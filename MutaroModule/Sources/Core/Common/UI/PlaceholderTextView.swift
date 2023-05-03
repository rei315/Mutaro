//
//  PlaceholderTextView.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//
//
//  PlaceholderTextView.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import UIKit

public final class PlaceholderTextView: UITextView {
    public var placeholder: String = "" {
        didSet {
            placeHolderLabel.text = placeholder
        }
    }

    public var placeholderColor: UIColor = .systemGray3 {
        didSet {
            placeHolderLabel.textColor = placeholderColor
        }
    }

    override public var text: String! {
        didSet {
            textDidChanged()
        }
    }

    override public var attributedText: NSAttributedString! {
        didSet {
            textDidChanged()
        }
    }

    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel().apply {
            $0.numberOfLines = 0
            $0.font = self.font
            $0.textColor = placeholderColor
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        return label
    }()

    public init(inset: UIEdgeInsets) {
        super.init(frame: .zero, textContainer: nil)
        setupView(padding: inset)
    }

    public init(padding: CGFloat) {
        super.init(frame: .zero, textContainer: nil)
        setupView(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(padding: UIEdgeInsets) {
        textContainerInset = padding

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChanged),
            name: UITextView.textDidChangeNotification,
            object: nil
        )

        placeHolderLabel.lets {
            addSubview($0)

            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(
                    equalTo: leadingAnchor,
                    constant: textContainerInset.left + textContainer.lineFragmentPadding
                ),
                $0.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
                $0.heightAnchor.constraint(
                    lessThanOrEqualTo: heightAnchor,
                    constant: textContainerInset.top + textContainerInset.bottom
                ),
                $0.widthAnchor.constraint(
                    equalTo: widthAnchor,
                    constant:
                    -(textContainerInset.left + textContainerInset.right
                        + textContainer.lineFragmentPadding * 2.0)
                )
            ])
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        placeHolderLabel.preferredMaxLayoutWidth =
            textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }

    @objc private func textDidChanged() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
