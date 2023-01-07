//
//  SettingViewController.swift
//
//
//  Created by minguk-kim on 2023/01/01.
//

import Core
import UIKit

class SettingViewController: UIViewController {

    let testImageView: UIImageView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = HomeTabPage.setting.title

        testImageView.lets {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .scaleAspectFit
            view.addSubview($0)
            $0.fillConstraint(to: view)
        }
        setupTest()
    }

    private func setupTest() {
        Task { @MainActor in
            //            await testImageView.loadImage(with: .mutaro0, size: testImageView.frame.size)
        }
    }
}
