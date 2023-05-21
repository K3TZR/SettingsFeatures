// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SettingsFeatures",
  platforms: [
    .macOS(.v13),
  ],
  
  products: [
    .library(name: "SettingsFeature", targets: ["SettingsFeature"]),
    .library(name: "SettingsColorsFeature", targets: ["SettingsColorsFeature"]),
    .library(name: "SettingsGpsFeature", targets: ["SettingsGpsFeature"]),
    .library(name: "SettingsNetworkFeature", targets: ["SettingsNetworkFeature"]),
    .library(name: "SettingsOtherFeature", targets: ["SettingsOtherFeature"]),
    .library(name: "SettingsPhoneCwFeature", targets: ["SettingsPhoneCwFeature"]),
    .library(name: "SettingsProfilesFeature", targets: ["SettingsProfilesFeature"]),
    .library(name: "SettingsRadioFeature", targets: ["SettingsRadioFeature"]),
    .library(name: "SettingsTxFeature", targets: ["SettingsTxFeature"]),
    .library(name: "SettingsXvtrFeature", targets: ["SettingsXvtrFeature"]),
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
    // ColorsFeature
    .target(name: "SettingsColorsFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // GpsFeature
    .target(name: "SettingsGpsFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // NetworkFeature
    .target(name: "SettingsNetworkFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // OtherFeature
    .target(name: "SettingsOtherFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // PhoneCwFeature
    .target(name: "SettingsPhoneCwFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // ProfilesFeature
    .target(name: "SettingsProfilesFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // RadioFeature
    .target(name: "SettingsRadioFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // TxFeature
    .target(name: "SettingsTxFeature", dependencies: [
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // XvtrFeature
    .target(name: "SettingsXvtrFeature", dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),

    // SettingsFeature
    .target(name: "SettingsFeature", dependencies: [
      "SettingsColorsFeature",
      "SettingsGpsFeature",
      "SettingsNetworkFeature",
      "SettingsOtherFeature",
      "SettingsPhoneCwFeature",
      "SettingsProfilesFeature",
      "SettingsRadioFeature",
      "SettingsTxFeature",
      "SettingsXvtrFeature",
      .product(name: "ApiIntView", package: "CustomControlFeatures"),
      .product(name: "ApiStringView", package: "CustomControlFeatures"),
      .product(name: "FlexApi", package: "ApiFeatures"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
  
  // --------------- Tests ---------------
)
