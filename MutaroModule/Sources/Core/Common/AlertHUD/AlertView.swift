//
//  AlertView.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import UIKit

public final class AlertView: UIView {
    private let alertLabel: UILabel = .init()

    public init(width: CGFloat, height: CGFloat) {
        super.init(frame: .init(x: 0, y: 0, width: width, height: height))
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = rect.height / 2
    }

    private func setupView() {
        clipsToBounds = true

        alertLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)

            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }

    func show(
        _ title: String,
        backgroundColor: UIColor,
        font: UIFont,
        textColor: UIColor
    ) {
        self.backgroundColor = backgroundColor
        alertLabel.lets {
            $0.text = title
            $0.font = font
            $0.textColor = textColor
        }
    }
}
