//
//  RootComponent.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Client
import Core
import ImageLoader
import KeychainStore
import NeedleFoundation

import AppIntroductionFeature
import HomeFeature
import MyAppsFeature
import MyAppToolsFeature
import RegisterJWTFeature
import SettingFeature

final class RootComponent: BootstrapComponent {
    public var appIntroductionFeatureBuilder: any AppIntroductionFeatureBuildable {
        shared {
            AppIntroductionFeatureBuilderComponent(parent: self)
                .appIntroductionBuilder()
        }
    }

    public var settingFeatureBuilder: any SettingFeatureBuildable {
        shared {
            SettingFeatureBuilderComponent(parent: self)
                .settingFeatureBuilder()
        }
    }

    public var homeFeatureBuilder: any HomeFeatureBuildable {
        shared {
            HomeFeatureBuilderComponent(parent: self)
                .homeFeatureBuilder()
        }
    }

    public var myAppsFeatureBuilder: any MyAppsFeatureBuildable {
        shared {
            MyAppsFeatureBuilderComponent(parent: self)
                .myAppsFeatureBuilder()
        }
    }

    public var registerJWTFeatureBuilder: any RegisterJWTFeatureBuildable {
        shared {
            RegisterJWTFeatureBuilderComponent(parent: self)
                .registerJWTFeatureBuilder()
        }
    }

    public var myAppToolsFeatureBuilder: any MyAppToolsFeatureBuildable {
        shared {
            MyAppToolsFeatureComponent(parent: self)
                .myAppToolsFeatureBuilder()
        }
    }

    public var client: any Providable {
        shared {
            Provider()
        }
    }

    public var imageDownloadService: any ImageDownloadService {
        shared {
            ImageDownloadServiceImp()
        }
    }

    public var keychainDataStore: any KeychainDataStoreProtocol {
        shared {
            KeychainDataStore()
        }
    }
}
