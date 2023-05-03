// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SettingsFeatures",
  platforms: [
    .iOS(.v15),
    .macOS(.v13),
  ],
  
  products: [
    .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
  ],
  
  dependencies: [
    .package(url: "https://github.com/K3TZR/ApiFeatures.git", branch: "main"),
    .package(url: "https://github.com/K3TZR/SharedFeatures.git", branch: "main"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.42.0"),
  ],
  
  // --------------- Modules ---------------
  targets: [
    // SettingsFeature
    .target(name: "SettingsFeature",
            dependencies: [
              .product(name: "ApiIntView", package: "SharedFeatures"),
              .product(name: "ApiStringView", package: "SharedFeatures"),
              .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
              .product(name: "FlexApi", package: "ApiFeatures"),
              .product(name: "Shared", package: "SharedFeatures"),
            ]),
  ]
)
