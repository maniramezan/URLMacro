# URLMacro

[![CI](https://github.com/maniramezan/URLMacro/actions/workflows/ci.yml/badge.svg)](https://github.com/maniramezan/URLMacro/actions/workflows/ci.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmaniramezan%2FURLMacro%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/maniramezan/URLMacro)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmaniramezan%2FURLMacro%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/maniramezan/URLMacro)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A Swift freestanding expression macro that validates URLs at compile time. Never crash from a malformed URL string again — `#URL("...")` guarantees the URL is valid before your code even runs.

## Swift Macros

[Swift Macros](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros/) (introduced in Swift 5.9) enable compile-time code generation and validation. URLMacro leverages this to move URL validation from runtime to compile time, catching invalid URLs as build errors rather than runtime crashes.

## Installation

Add URLMacro to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/maniramezan/URLMacro", from: "1.0.0")
]
```

Then add `"URLMacro"` to your target's dependencies:

```swift
.target(
    name: "MyApp",
    dependencies: ["URLMacro"]
)
```

## Usage

```swift
import URLMacro

// Compile-time validated URL — guaranteed to be valid
let apple = #URL("https://www.apple.com")
let api = #URL("https://api.example.com/v1/users?page=1#top")
```

Invalid URLs produce compile-time errors:

```swift
let bad = #URL("not a url")
// error: #URL requires a valid URL literal

let interpolated = #URL("https://\(host).com")
// error: #URL does not support string interpolation
```

## License

MIT — see [LICENSE](LICENSE) for details.
