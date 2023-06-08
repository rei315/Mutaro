//
//  DevRootComponent.swift
//
//
//  Created by minguk-kim on 2023/06/08.
//

import Client
import Core
import ImageLoader
import NeedleFoundation

import AppIntroductionFeature
import HomeFeature
import MyAppsFeature
import MyAppToolsFeature
import RegisterJWTFeature
import SettingFeature

final class DevRootComponent: BootstrapComponent {
    var appIntroductionFeatureBuilder: AppIntroductionFeatureBuildable {
        shared {
            AppIntroductionFeatureBuilderComponent(parent: self)
                .appIntroductionBuilder()
        }
    }

    var settingFeatureBuilder: SettingFeatureBuildable {
        shared {
            SettingFeatureBuilderComponent(parent: self)
                .settingFeatureBuilder()
        }
    }

    var homeFeatureBuilder: HomeFeatureBuildable {
        shared {
            HomeFeatureBuilderComponent(parent: self)
                .homeFeatureBuilder()
        }
    }

    var myAppsFeatureBuilder: MyAppsFeatureBuildable {
        shared {
            MyAppsFeatureBuilderComponent(parent: self)
                .myAppsFeatureBuilder()
        }
    }

    var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable {
        shared {
            RegisterJWTFeatureBuilderComponent(parent: self)
                .registerJWTFeatureBuilder()
        }
    }

    var myAppToolsFeatureBuilder: MyAppToolsFeatureBuildable {
        shared {
            MyAppToolsFeatureComponent(parent: self)
                .myAppToolsFeatureBuilder()
        }
    }

    var client: Providable {
        shared {
            Provider()
        }
    }

    var imageDownloadService: ImageDownloadService {
        shared {
            ImageDownloadServiceImp()
        }
    }
}
