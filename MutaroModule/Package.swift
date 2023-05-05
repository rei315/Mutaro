// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let firebaseCrashlyticsDependencies: [Target.Dependency] = [
    "GoogleDataTransport",
    "FirebaseCrashlytics",
]

let firebaseAnalyticsDependencies: [Target.Dependency] = [
    "FBLPromises",
    "FirebaseAnalytics",
    "FirebaseAnalyticsSwift",
    "FirebaseCore",
    "FirebaseCoreInternal",
    "FirebaseInstallations",
    "GoogleAppMeasurement",
    "GoogleAppMeasurementIdentitySupport",
    "GoogleUtilities",
    "nanopb",
]

let debugSwiftSettings: [PackageDescription.SwiftSetting] = [
    .define("DEV", .when(configuration: .debug))
]

let unittestDependencies: [Target.Dependency] = [
    .product(name: "Quick", package: "Quick"),
    .product(name: "Nimble", package: "Nimble")
]

private extension PackageDescription.Target.Dependency {
    static let rSwift: Self = .product(name: "RswiftLibrary", package: "R.swift")
    static let needle: Self = .product(name: "NeedleFoundation", package: "needle")
}

let productionFeatures: [PackageDescription.Target.Dependency] = [
    "AppIntroductionFeature",
    "HomeViewFeature",
    "MyAppsFeature",
    "RegisterJWTFeature",
    "SettingFeature"
]

let package = Package(
    name: "MutaroModule",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "MutaroApp",
            targets: ["MutaroApp"]
        ),
        .library(
            name: "FirebaseSetup",
            targets: ["FirebaseSetup"]
        ),
        .library(name: "Resources", targets: ["Resources"]),
        .library(name: "HomeViewFeature", targets: ["HomeViewFeature"]),
        .library(name: "MyAppsFeature", targets: ["MyAppsFeature"]),
        .library(name: "RegisterJWTFeature", targets: ["RegisterJWTFeature"]),
        .library(name: "SettingFeature", targets: ["SettingFeature"])
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.3.2"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.51.0"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.51.8"),
        .package(url: "https://github.com/Kitura/Swift-JWT", from: "4.0.1"),
        .package(url: "https://github.com/Quick/Quick", from: "6.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "12.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "7.6.2"),
        .package(url: "https://github.com/uber/needle.git", from: "0.23.0")
    ],
    targets: [
        .target(
            name: "MutaroApp",
            dependencies: productionFeatures
        ),
        .target(
            name: "Resources",
            dependencies: []
        ),
        .target(
            name: "AppIntroductionFeature",
            dependencies: [
                "Core",
                .rSwift
            ],
            path: "./Sources/Features/AppIntroduction",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "HomeViewFeature",
            dependencies: [
                "Core",
                "Resources",
                .rSwift
            ],
            path: "./Sources/Features/HomeView",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "MyAppsFeature",
            dependencies: [
                "Client",
                "Core",
                "ImageLoader",
                "JWTGenerator",
                "KeychainStore",
                "Resources",
                .rSwift
            ],
            path: "./Sources/Features/MyApps",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "RegisterJWTFeature",
            dependencies: [
                "JWTGenerator",
                "KeychainStore",
                "Core",
                "Resources",
                .rSwift
            ],
            path: "./Sources/Features/RegisterJWT",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "SettingFeature",
            dependencies: [
                "Core",
                "Resources",
                .rSwift
            ],
            path: "./Sources/Features/Setting",
            swiftSettings: debugSwiftSettings
        ),
        .target(
            name: "Core",
            dependencies: [
                "ImageLoader",
                .needle
            ]
        ),
        .target(
            name: "Client",
            dependencies: []
        ),
        .target(
            name: "JWTGenerator",
            dependencies: [
                .product(name: "SwiftJWT", package: "Swift-JWT")
            ]
        ),
        .testTarget(
            name: "JWTGeneratorTests",
            dependencies: [
                "JWTGenerator"
            ] + unittestDependencies
        ),
        .target(
            name: "KeychainStore",
            dependencies: []
        ),
        .target(
            name: "FirebaseSetup",
            dependencies: firebaseCrashlyticsDependencies + firebaseAnalyticsDependencies,
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .target(
            name: "ImageLoader",
            dependencies: [
                "Kingfisher"
            ]
        ),
        .binaryTarget(
            name: "FirebaseCrashlytics",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/FirebaseCrashlytics.xcframework"
        ),
        .binaryTarget(
            name: "GoogleDataTransport",
            path: "XCFrameworks/Firebase/FirebaseCrashlytics/GoogleDataTransport.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAnalytics",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseAnalytics.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseAnalyticsSwift",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseAnalyticsSwift.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurement",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurement.xcframework"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupport",
            path:
                "XCFrameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCore",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseCore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreInternal",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseCoreInternal.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseInstallations",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FirebaseInstallations.xcframework"
        ),
        .binaryTarget(
            name: "GoogleUtilities",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleUtilities.xcframework"
        ),
        .binaryTarget(
            name: "FBLPromises",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/FBLPromises.xcframework"
        ),
        .binaryTarget(
            name: "nanopb",
            path: "XCFrameworks/Firebase/FirebaseAnalytics/nanopb.xcframework"
        )
    ]
)
