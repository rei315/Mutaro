//
//  File.swift
//
//
//  Created by minguk-kim on 2023/05/06.
//

import Core
import NeedleFoundation

import AppIntroductionFeature
import HomeViewFeature
import SettingFeature
import MyAppsFeature
import RegisterJWTFeature

final class RootComponent: BootstrapComponent {
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

    var homeFeatureBuilder: HomeViewFeatureBuildable {
        shared {
            HomeFeatureBuilderComponent(parent: self)
                .homeViewFeatureBuilder()
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
}
