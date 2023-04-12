// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Director",
    platforms: [.iOS(.v13)],
    swiftLanguageVersions: [.v5],
    dependencies: [],
    products: [

        .library(
            name: "Director", 
            targets: ["Core"]
        ),

        .library(
            name: "DirectorDI", 
            targets: ["DI"]
        )

    ],
    targets: [

        .target(
            name: "Core",
            path: "Sources/Core",
            dependencies: []
        ),

        .target(
            name: "DI",
            path: "Sources/DI",
            dependencies: [

                .target(name: "Core"),

                .package(
                    name: "Swinject",
                    url: "https://github.com/Swinject/Swinject",
                    .upToNextMajor(from: .init(2, 0, 0))
                )

            ]
        )

    ]
)
