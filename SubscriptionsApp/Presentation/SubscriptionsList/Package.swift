// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubscriptionsList",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SubscriptionsList",
            targets: ["SubscriptionsList"]),
    ],
    dependencies: [
        .package(path: "../../Core/Models"),
        .package(path: "../../Core/SharedUtilities"),
        .package(path: "../../Domain/SubscriptionsUseCases"),
        .package(path: "../../Core/CoreResources")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SubscriptionsList",
            dependencies: [
                "Models",
                "SharedUtilities",
                "SubscriptionsUseCases",
                "CoreResources"
            ]),
        .testTarget(
            name: "SubscriptionsListTests",
            dependencies: ["SubscriptionsList"]
        ),
    ]
)
