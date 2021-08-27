// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Uno",
  platforms: [
    .iOS(.v13), .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "Uno",
      targets: [
        "Uno"
      ]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-crypto.git", branch: "main"),
  ],
  targets: [
    .target(
      name: "Uno",
      dependencies: [
        .productItem(name: "Crypto", package: "swift-crypto", condition: .when(platforms: [.windows, .linux]))
      ]
    ),
    .testTarget(
      name: "UnoTests",
      dependencies: [
        "Uno"
      ]
    ),
  ]
)
