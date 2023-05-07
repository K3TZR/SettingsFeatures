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
    .library(name: "ColorsFeature", targets: ["ColorsFeature"]),
    .library(name: "GpsFeature", targets: ["GpsFeature"]),
    .library(name: "NetworkFeature", targets: ["NetworkFeature"]),
    .library(name: "OtherFeature", targets: ["OtherFeature"]),
    .library(name: "PhoneCwFeature", targets: ["PhoneCwFeature"]),
    .library(name: "ProfilesFeature", targets: ["ProfilesFeature"]),
    .library(name: "RadioFeature", targets: ["RadioFeature"]),
    .library(name: "TxFeature", targets: ["TxFeature"]),
    .library(name: "XvtrFeature", targets: ["XvtrFeature"]),
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
    // ColorsFeature
    .target(name: "ColorsFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // GpsFeature
    .target(name: "GpsFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // NetworkFeature
    .target(name: "NetworkFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // OtherFeature
    .target(name: "OtherFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // PhoneCwFeature
    .target(name: "PhoneCwFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // ProfilesFeature
    .target(name: "ProfilesFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // RadioFeature
    .target(name: "RadioFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // TxFeature
    .target(name: "TxFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // XvtrFeature
    .target(name: "XvtrFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

   // SettingsFeature
    .target(name: "SettingsFeature", dependencies: [
      "ColorsFeature",
      "GpsFeature",
      "NetworkFeature",
      "OtherFeature",
      "PhoneCwFeature",
      "ProfilesFeature",
      "RadioFeature",
      "TxFeature",
      "XvtrFeature",
      .product(name: "ApiIntView", package: "CustomControlFeature"),
      .product(name: "ApiStringView", package: "CustomControlFeature"),
      .product(name: "FlexApi", package: "ApiFeature"),
      .product(name: "Shared", package: "ApiFeature"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
  
  // --------------- Tests ---------------
)
