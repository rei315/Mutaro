//
//  RootComponentSpy.swift
//
//
//  Created by minguk-kim on 2023/08/06.
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

final public class RootComponentSpy: BootstrapComponent {
    public var appIntroductionFeatureBuilder: AppIntroductionFeatureBuildable {
        shared {
            AppIntroductionFeatureBuilderComponent(parent: self)
                .appIntroductionBuilder()
        }
    }

    public var settingFeatureBuilder: SettingFeatureBuildable {
        shared {
            SettingFeatureBuilderComponent(parent: self)
                .settingFeatureBuilder()
        }
    }

    public var homeFeatureBuilder: HomeFeatureBuildable {
        shared {
            HomeFeatureBuilderComponent(parent: self)
                .homeFeatureBuilder()
        }
    }

    public var myAppsFeatureBuilder: MyAppsFeatureBuildable {
        shared {
            MyAppsFeatureBuilderComponent(parent: self)
                .myAppsFeatureBuilder()
        }
    }

    public var registerJWTFeatureBuilder: RegisterJWTFeatureBuildable {
        shared {
            RegisterJWTFeatureBuilderComponent(parent: self)
                .registerJWTFeatureBuilder()
        }
    }

    public var myAppToolsFeatureBuilder: MyAppToolsFeatureBuildable {
        shared {
            MyAppToolsFeatureComponent(parent: self)
                .myAppToolsFeatureBuilder()
        }
    }

    public var client: Providable {
        shared {
            Provider()
        }
    }

    public var imageDownloadService: ImageDownloadService {
        shared {
            ImageDownloadServiceImp()
        }
    }
}
