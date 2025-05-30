// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "UTS",
    products: [
        .library(name: "UTS", targets: ["UTS"]),
        .executable(name: "UTSrun", targets: ["UTSrun"]),
    ],
    targets: [
        .target(
            name: "UTS",
            dependencies: [
                .target(name: "UTSwin", condition: .when(platforms: [.windows])),
            ],
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-validate-tbd-against-ir=none"])
            ]
        ),
        .target(name: "UTSwin", linkerSettings: [.linkedLibrary("wsock32")]),
        .executableTarget(name: "UTSrun", dependencies: ["UTS"]),
        .testTarget(name: "UTSTests", dependencies: ["UTS"]),
    ]
)
