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
    ],
    targets: [
        .target(
            name: "HamerKit",
            dependencies: ["SwiftSoup"]
        ),
        .testTarget(
            name: "HamerKitTests",
            dependencies: ["HamerKit"]
        ),
    ]
)
