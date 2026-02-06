# Contributing to URLMacro

Thanks for your interest in contributing! All contributions are welcome — bug reports, feature requests, documentation improvements, and code changes.

## Reporting Issues

Open a [GitHub issue](https://github.com/maniramezan/URLMacro/issues) with:

- A clear description of the problem or suggestion
- Steps to reproduce (for bugs)
- Expected vs actual behavior

## Submitting Pull Requests

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-change`
3. Make your changes
4. Run tests: `swift test`
5. Run the linter: `swift package plugin lint-source-code`
6. Commit with a clear message
7. Open a pull request against `main`

## Code Style

This project uses [swift-format](https://github.com/swiftlang/swift-format) for consistent formatting. Please run the linter before submitting.

## Development

```bash
# Build
swift build

# Test
swift test

# Lint
swift package plugin lint-source-code
```
