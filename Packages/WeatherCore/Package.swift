// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherCore",
    
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)
    ],
    
    products: [
        .library(name: "WeatherCore", targets: ["WeatherCore"]),
    ],

    dependencies: [
        .package(url: "https://github.com/adamayoung/OpenWeather.git", .branch("main"))
    ],

    targets: [
        .target(name: "WeatherCore", dependencies: ["OpenWeather"]),
        .testTarget(name: "WeatherCoreTests", dependencies: ["WeatherCore"])
    ]
)
