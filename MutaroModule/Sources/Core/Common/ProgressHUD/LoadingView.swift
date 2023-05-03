//
//  LoadingView.swift
//
//
//  Created by minguk-kim on 2023/01/15.
//

import UIKit

public final class LoadingView: UIView {
    private let indicator: UIActivityIndicatorView = .init()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.5)
        indicator.lets {
            $0.style = .large
            $0.startAnimating()
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)

            NSLayoutConstraint.activate([
                $0.centerXAnchor.constraint(equalTo: centerXAnchor),
                $0.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
}
