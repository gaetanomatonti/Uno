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
    .package(url: "https://github.com/apple/swift-crypto.git", .upToNextMajor(from: "2.0.0")),
    .package(url: "https://github.com/gaetanomatonti/FiveBits.git", .upToNextMajor(from: "0.1.0"))
  ],
  targets: [
    .target(
      name: "Uno",
      dependencies: [
        .product(name: "Crypto", package: "swift-crypto"),
        .product(name: "FiveBits", package: "FiveBits")
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
