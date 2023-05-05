//
//  AlertView.swift
//
//
//  Created by minguk-kim on 2023/05/03.
//

import AppResource
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
        backgroundColor = R.color.grey()
        clipsToBounds = true

        alertLabel.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = FontSize.base.ofBoldFont()
            $0.textColor = R.color.white()

            addSubview($0)

            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }

    func setupTitle(_ title: String) {
        alertLabel.text = title
    }
}
