import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct URLMacroPlugin: CompilerPlugin {
  let providingMacros: [Macro.Type] = [
    URLMacro.self
  ]
}
