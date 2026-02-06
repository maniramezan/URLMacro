import Foundation
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `#URL` macro that performs compile-time URL validation.
///
/// This macro expands a string literal into a `URL(string:)!` call after validating
/// that the literal is a well-formed URL with a scheme. Because validation happens
/// at compile time, the force unwrap in the expansion is guaranteed to succeed.
public enum URLMacro: ExpressionMacro {

  /// Expands the `#URL("...")` macro into a validated `URL` expression.
  ///
  /// - Parameters:
  ///   - node: The macro expansion syntax node containing the arguments.
  ///   - context: The macro expansion context for emitting diagnostics.
  /// - Returns: An expression syntax that constructs a `URL` from the validated literal.
  /// - Throws: `DiagnosticsError` if the argument is not a valid, static URL string literal.
  public static func expansion(
    of node: some FreestandingMacroExpansionSyntax,
    in context: some MacroExpansionContext
  ) throws -> ExprSyntax {
    guard let argument = node.arguments.first?.expression.as(StringLiteralExprSyntax.self) else {
      throw DiagnosticsError(
        diagnostics: [
          Diagnostic(
            node: Syntax(node),
            message: URLMacroDiagnostic("#URL requires a string literal")
          )
        ]
      )
    }

    let segments = argument.segments
    if segments.contains(where: { segment in
      if case .expressionSegment = segment { return true }
      return false
    }) {
      throw DiagnosticsError(
        diagnostics: [
          Diagnostic(
            node: Syntax(argument),
            message: URLMacroDiagnostic("#URL does not support string interpolation")
          )
        ]
      )
    }

    let literal = segments.compactMap { segment -> String? in
      if case .stringSegment(let value) = segment {
        return value.content.text
      }
      return nil
    }.joined()

    guard let url = URL(string: literal), url.scheme != nil else {
      throw DiagnosticsError(
        diagnostics: [
          Diagnostic(
            node: Syntax(argument),
            message: URLMacroDiagnostic("#URL requires a valid URL literal")
          )
        ]
      )
    }

    return ExprSyntax("URL(string: \(argument))!")
  }
}

private struct URLMacroDiagnostic: DiagnosticMessage {
  let message: String
  let diagnosticID: MessageID = MessageID(domain: "URLMacro", id: "InvalidURL")
  let severity: DiagnosticSeverity = .error

  init(_ message: String) {
    self.message = message
  }
}
