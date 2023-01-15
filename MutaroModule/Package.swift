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

let firebaseFirestoreDependencies: [Target.Dependency] = [
    "BoringSSL-GRPC",
    "FirebaseCoreExtension",
    "FirebaseFirestore",
    "FirebaseFirestoreSwift",
    "FirebaseSharedSwift",
    "Libuv-gRPC",
    "abseil",
    "gRPC-C++",
    "gRPC-Core",
    "leveldb-library",
]

let package = Package(
    name: "MutaroModule",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Features",
            targets: ["Features"]),
        .library(
            name: "Core",
            targets: ["Core"]),
        .library(
            name: "FirebaseSetup",
            targets: ["FirebaseSetup"]
        ),
        .library(
            name: "ImageLoader",
            targets: ["ImageLoader"]
        ),
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        ),
        .library(
            name: "AppResource",
            targets: ["AppResource"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", exact: "6.6.2"),
        .package(url: "https://github.com/apple/swift-format", branch: "main"),
    ],
    targets: [
        .target(
            name: "Features",
            dependencies: ["ImageLoader", "Core", "Repositories", "AppResource"],
            swiftSettings: [
                .define("DEV", .when(configuration: .debug))
            ]
        ),
        .target(
            name: "Core",
            dependencies: ["ImageLoader"]
        ),
        .target(
            name: "Repositories",
            dependencies: firebaseFirestoreDependencies + firebaseAnalyticsDependencies + ["Core"],
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .target(
            name: "FirebaseSetup",
            dependencies: firebaseCrashlyticsDependencies + firebaseAnalyticsDependencies,
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        .target(
            name: "AppResource",
            dependencies: [],
            exclude: [
                "swiftgen.yml"
            ],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
            ]
        ),
        .target(
            name: "ImageLoader",
            dependencies: []
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
        ),
        .binaryTarget(
            name: "BoringSSL-GRPC",
            path: "XCFrameworks/Firebase/FirebaseFirestore/BoringSSL-GRPC.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseCoreExtension",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseCoreExtension.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseFirestore",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseFirestore.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseFirestoreSwift",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseFirestoreSwift.xcframework"
        ),
        .binaryTarget(
            name: "FirebaseSharedSwift",
            path: "XCFrameworks/Firebase/FirebaseFirestore/FirebaseSharedSwift.xcframework"
        ),
        .binaryTarget(
            name: "Libuv-gRPC",
            path: "XCFrameworks/Firebase/FirebaseFirestore/Libuv-gRPC.xcframework"
        ),
        .binaryTarget(
            name: "abseil",
            path: "XCFrameworks/Firebase/FirebaseFirestore/abseil.xcframework"
        ),
        .binaryTarget(
            name: "gRPC-C++",
            path: "XCFrameworks/Firebase/FirebaseFirestore/gRPC-C++.xcframework"
        ),
        .binaryTarget(
            name: "gRPC-Core",
            path: "XCFrameworks/Firebase/FirebaseFirestore/gRPC-Core.xcframework"
        ),
        .binaryTarget(
            name: "leveldb-library",
            path: "XCFrameworks/Firebase/FirebaseFirestore/leveldb-library.xcframework"
        )
    ]
)
