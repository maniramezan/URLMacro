import Foundation
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import Testing
import URLMacro

@testable import URLMacroMacros

private let testMacros: [String: any Macro.Type] = [
  "URL": URLMacroMacros.URLMacro.self
]

// MARK: - Happy Path Tests

@Test func httpsURL() {
  assertMacroExpansion(
    #"""
    #URL("https://www.apple.com")
    """#,
    expandedSource: #"""
      URL(string: "https://www.apple.com")!
      """#,
    macros: testMacros
  )
}

@Test func httpURL() {
  assertMacroExpansion(
    #"""
    #URL("http://example.com")
    """#,
    expandedSource: #"""
      URL(string: "http://example.com")!
      """#,
    macros: testMacros
  )
}

@Test func urlWithPathQueryAndFragment() {
  assertMacroExpansion(
    #"""
    #URL("https://example.com/path/to/page?key=value&other=123#section")
    """#,
    expandedSource: #"""
      URL(string: "https://example.com/path/to/page?key=value&other=123#section")!
      """#,
    macros: testMacros
  )
}

@Test func urlWithPort() {
  assertMacroExpansion(
    #"""
    #URL("https://localhost:8080/api")
    """#,
    expandedSource: #"""
      URL(string: "https://localhost:8080/api")!
      """#,
    macros: testMacros
  )
}

@Test func ftpURL() {
  assertMacroExpansion(
    #"""
    #URL("ftp://files.example.com/readme.txt")
    """#,
    expandedSource: #"""
      URL(string: "ftp://files.example.com/readme.txt")!
      """#,
    macros: testMacros
  )
}

@Test func customSchemeURL() {
  assertMacroExpansion(
    #"""
    #URL("myapp://deep/link")
    """#,
    expandedSource: #"""
      URL(string: "myapp://deep/link")!
      """#,
    macros: testMacros
  )
}

@Test func urlWithEncodedCharacters() {
  assertMacroExpansion(
    #"""
    #URL("https://example.com/search?q=hello%20world")
    """#,
    expandedSource: #"""
      URL(string: "https://example.com/search?q=hello%20world")!
      """#,
    macros: testMacros
  )
}

// MARK: - End-to-End Usage

@Test func endToEndUsage() {
  let url = #URL("https://www.apple.com")
  #expect(url.scheme == "https")
  #expect(url.host == "www.apple.com")
}

// MARK: - Error Case Tests

@Test func noSchemeProducesDiagnostic() {
  assertMacroExpansion(
    #"""
    #URL("example.com")
    """#,
    expandedSource: #"""
      #URL("example.com")
      """#,
    diagnostics: [
      DiagnosticSpec(message: "#URL requires a valid URL literal", line: 1, column: 6)
    ],
    macros: testMacros
  )
}

@Test func emptyStringProducesDiagnostic() {
  assertMacroExpansion(
    #"""
    #URL("")
    """#,
    expandedSource: #"""
      #URL("")
      """#,
    diagnostics: [
      DiagnosticSpec(message: "#URL requires a valid URL literal", line: 1, column: 6)
    ],
    macros: testMacros
  )
}

@Test func stringInterpolationProducesDiagnostic() {
  assertMacroExpansion(
    #"""
    #URL("https://\(domain).com")
    """#,
    expandedSource: #"""
      #URL("https://\(domain).com")
      """#,
    diagnostics: [
      DiagnosticSpec(message: "#URL does not support string interpolation", line: 1, column: 6)
    ],
    macros: testMacros
  )
}

@Test func nonStringLiteralProducesDiagnostic() {
  assertMacroExpansion(
    #"""
    #URL(someVariable)
    """#,
    expandedSource: #"""
      #URL(someVariable)
      """#,
    diagnostics: [
      DiagnosticSpec(message: "#URL requires a string literal", line: 1, column: 1)
    ],
    macros: testMacros
  )
}

@Test func integerLiteralProducesDiagnostic() {
  assertMacroExpansion(
    #"""
    #URL(42)
    """#,
    expandedSource: #"""
      #URL(42)
      """#,
    diagnostics: [
      DiagnosticSpec(message: "#URL requires a string literal", line: 1, column: 1)
    ],
    macros: testMacros
  )
}
