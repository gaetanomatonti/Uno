// swift-tools-version:5.3
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
    .package(url: "https://github.com/apple/swift-crypto.git", from: "1.1.0"),
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
