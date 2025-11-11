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
    targets: [
        .target(
            name: "HamerKit"
        ),
        .testTarget(
            name: "HamerKitTests",
            dependencies: ["HamerKit"]
        ),
    ]
)
