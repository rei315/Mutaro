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
        .iOS(.v15),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "AppModule",
            targets: ["AppModule"]),
        .library(
            name: "CommonAppModule",
            targets: ["CommonAppModule"]),
        .library(
            name: "BuildModule",
            targets: ["BuildModule"]),
        .library(
            name: "FirebaseSetupModule",
            targets: ["FirebaseSetupModule"]
        ),
        .library(
            name: "ImageModule",
            targets: ["ImageModule"]
        ),
        .library(
            name: "MutaroApiModule",
            targets: ["MutaroApiModule"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-format", branch: "main"),
    ],
    targets: [
        .target(
            name: "AppModule",
            dependencies: ["ImageModule", "CommonAppModule", "MutaroApiModule"]
        ),
        .target(
            name: "CommonAppModule",
            dependencies: ["ImageModule"]
        ),
        .target(
            name: "MutaroApiModule",
            dependencies: firebaseFirestoreDependencies + firebaseAnalyticsDependencies + ["CommonAppModule"],
            linkerSettings: [
                .unsafeFlags(["-ObjC"]),
            ]
        ),
        .target(
            name: "BuildModule",
            dependencies: ["swift-format"]
        ),
        .target(
            name: "FirebaseSetupModule",
            dependencies: firebaseCrashlyticsDependencies + firebaseAnalyticsDependencies,
            linkerSettings: [
                .unsafeFlags(["-ObjC"]),
            ]
        ),
        .target(
            name: "ImageModule",
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
            path: "XCFrameworks/Firebase/FirebaseAnalytics/GoogleAppMeasurementIdentitySupport.xcframework"
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
        ),
    ]
)
