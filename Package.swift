// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SettingsFeatures",
  platforms: [
    .macOS(.v13),
  ],
  
  products: [
    .library(name: "SettingsPanel", targets: ["SettingsPanel"]),
    .library(name: "ColorSettings", targets: ["ColorSettings"]),
    .library(name: "GpsSettings", targets: ["GpsSettings"]),
    .library(name: "NetworkSettings", targets: ["NetworkSettings"]),
    .library(name: "OtherSettings", targets: ["OtherSettings"]),
    .library(name: "PhoneCwSettings", targets: ["PhoneCwSettings"]),
    .library(name: "ProfileSettings", targets: ["ProfileSettings"]),
    .library(name: "RadioSettings", targets: ["RadioSettings"]),
    .library(name: "TxSettings", targets: ["TxSettings"]),
    .library(name: "XvtrSettings", targets: ["XvtrSettings"]),
  ],
  
  dependencies: [
    // ----- K3TZR -----
    .package(url: "https://github.com/K3TZR/ApiFeatures.git", branch: "main"),
    .package(url: "https://github.com/K3TZR/CustomControlFeatures.git", branch: "main"),
    // ----- OTHER -----
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.42.0"),
  ],
  
  // --------------- Modules ---------------
  targets: [
    // ColorSettings
    .target(name: "ColorSettings", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // GpsSettings
    .target(name: "GpsSettings", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // NetworkSettings
    .target(name: "NetworkSettings", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // OtherSettings
    .target(name: "OtherSettings", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // PhoneCwSettings
    .target(name: "PhoneCwSettings", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // ProfileSettings
    .target(name: "ProfileSettings", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // RadioSettings
    .target(name: "RadioSettings", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // TxSettings
    .target(name: "TxSettings", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // XvtrSettings
    .target(name: "XvtrSettings", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // SettingsPanel
    .target(name: "SettingsPanel", dependencies: [
      "ColorSettings",
      "GpsSettings",
      "NetworkSettings",
      "OtherSettings",
      "PhoneCwSettings",
      "ProfileSettings",
      "RadioSettings",
      "TxSettings",
      "XvtrSettings",
      .product(name: "ApiIntView", package: "CustomControlFeatures"),
      .product(name: "ApiStringView", package: "CustomControlFeatures"),
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
  
  // --------------- Tests ---------------
)
