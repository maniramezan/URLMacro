import CompilerPluginSupport
// swift-tools-version:6.2
import PackageDescription

let package = Package(
  name: "URLMacro",
  platforms: [
    .iOS(.v17),
    .macOS(.v13),
  ],
  products: [
    .library(name: "URLMacro", targets: ["URLMacro"])
  ],
  dependencies: [
    .package(url: "https://github.com/maniramezan/TestCommonsMacroTesting.git", from: "0.1.0"),
    .package(url: "https://github.com/swiftlang/swift-syntax", "600.0.0"..<"700.0.0"),
    .package(url: "https://github.com/swiftlang/swift-format", "600.0.0"..<"700.0.0"),
  ],
  targets: [
    .macro(
      name: "URLMacroMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),
    .target(
      name: "URLMacro",
      dependencies: ["URLMacroMacros"]
    ),
    .testTarget(
      name: "URLMacroTests",
      dependencies: [
        "URLMacro",
        "URLMacroMacros",
        .product(name: "TestCommonsMacroTesting", package: "TestCommonsMacroTesting"),
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)
