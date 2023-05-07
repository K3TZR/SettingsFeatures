// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SettingsFeature",
  platforms: [
    .macOS(.v13),
  ],
  
  products: [
    .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
  ],
  
  dependencies: [
    // ----- K3TZR -----
    .package(url: "https://github.com/K3TZR/ApiFeature.git", branch: "main"),
    .package(url: "https://github.com/K3TZR/CustomControlFeature.git", branch: "main"),
    // ----- OTHER -----
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.42.0"),
  ],
  
  // --------------- Modules ---------------
  targets: [
    // SettingsFeature
    .target(name: "SettingsFeature", dependencies: [
      .product(name: "ApiIntView", package: "CustomControlFeature"),
      .product(name: "ApiStringView", package: "CustomControlFeature"),
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "Shared", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
  
  // --------------- Tests ---------------
)
