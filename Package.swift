// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "HamerKit",
    platforms: [.iOS("16.0")],
    products: [
        .library(
            name: "HamerKit",
            targets: ["HamerKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/scinfu/SwiftSoup.git", .upToNextMajor(from: "2.10.1")),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.1"),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.3.0")),
    ],
    targets: [
        .target(
            name: "HamerKit",
            dependencies: [
                "SwiftSoup",
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
            ]
        ),
        .testTarget(
            name: "HamerKitTests",
            dependencies: ["HamerKit"]
        ),
    ]
)
