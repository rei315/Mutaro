//
//  MyAppsFeatureComponent.swift
//  MutaroApp
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import Foundation
import ImageLoader
import NeedleFoundation
import UIKit

public protocol MyAppsFeatureDependency: Dependency {
    var client: Providable { get }
    var imageDownloadService: ImageDownloadService { get }
    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable { get }
    var myAppToolsFeatureBuilder: MyAppToolsFeatureBuildable { get }
}

class MyAppsFeatureBuilder: Builder<MyAppsFeatureDependency>, MyAppsFeatureBuildable {
    @MainActor
    public func build() -> UIViewController {
        let myAppsVC = MyAppsViewController(
            dependency: .init(
                viewModel: .init(
                    environment: environment
                )
            )
        )
        let navigationVC = UINavigationController(rootViewController: myAppsVC)
        navigationVC.view.backgroundColor = .white
        let imageName = "app"
        let normalTabColor = UIColor(resource: .navy)
        let normalTabImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: normalTabColor)
        let normalTabImage = UIImage(systemName: imageName, withConfiguration: normalTabImageConfiguration)
        let selectedTabColor = UIColor(resource: .turquoise)
        let selectedTabImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: selectedTabColor)
        let selectedTabImage = UIImage(systemName: imageName, withConfiguration: selectedTabImageConfiguration)

        navigationVC.tabBarItem = .init(
            title: "MyApps",
            image: normalTabImage,
            selectedImage: selectedTabImage
        )
        return navigationVC
    }

    private var environment: MyAppsFeatureEnvironment {
        .init(
            appInfoUseCase: appInfoUseCase,
            imageDownloadService: dependency.imageDownloadService,
            router: router
        )
    }

    private var router: MyAppsRoutable {
        MyAppsRouter(
            dependency: .init(
                registerJWTFeatureBuilder: dependency.registerJWTFeatureBuilder,
                myAppToolsFeatureBuilder: dependency.myAppToolsFeatureBuilder
            )
        )
    }

    private var appInfoUseCase: AppInfoUseCase {
        AppInfoUseCaseImpl(client: dependency.client)
    }
}

public class MyAppsFeatureBuilderComponent: Component<MyAppsFeatureDependency>, FeatureMyApps {
    public func myAppsFeatureBuilder() -> Core.MyAppsFeatureBuildable {
        MyAppsFeatureBuilder(dependency: dependency)
    }
}
