// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Director",
    platforms: [.iOS(.v13)],
    products: [

        .library(
            name: "Director", 
            targets: ["Director"]
        ),

        .library(
            name: "DirectorDI", 
            targets: ["DirectorDI"]
        )

    ],
    dependencies: [

        .package(
            name: "Swinject",
            url: "https://github.com/Swinject/Swinject",
            .upToNextMajor(from: .init(2, 0, 0))
        )

    ],
    targets: [

        .target(
            name: "Director",
            dependencies: [],
            path: "Sources/Core"
        ),

        .target(
            name: "DirectorDI",
            dependencies: [

                .target(name: "Director"), // Core

                .product(
                    name: "Swinject", 
                    package: "Swinject"
                )

            ],
            path: "Sources/DI"
        )

    ],
    swiftLanguageVersions: [.v5]
)
