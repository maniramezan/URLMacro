import Foundation

/// A macro that validates a URL string literal at compile time and returns a `URL` value.
///
/// Use `#URL` to create `URL` values that are guaranteed to be valid at compile time,
/// eliminating the need for runtime `nil` checks or force unwrapping.
///
/// ```swift
/// let url = #URL("https://www.apple.com")
/// ```
///
/// The macro validates that:
/// - The argument is a static string literal (no interpolation)
/// - The string is a well-formed URL
/// - The URL contains a scheme (e.g., `https`, `ftp`)
///
/// If any validation fails, a compile-time error is produced:
///
/// ```swift
/// let bad = #URL("not a url")  // error: #URL requires a valid URL literal
/// ```
///
/// - Parameter string: A static string literal containing a valid URL.
/// - Returns: A `URL` value that is guaranteed to be valid.
@freestanding(expression)
public macro URL(_ string: String) -> URL =
  #externalMacro(
    module: "URLMacroMacros",
    type: "URLMacro"
  )
