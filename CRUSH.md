# CRUSH Configuration

## Build/Test Commands
```bash
# No build system detected - add commands as project grows
# Example: npm test, cargo test, go test, python -m pytest
```

## Code Style Guidelines

### General
- Use consistent indentation (2 spaces for web, 4 for Python/Go)
- Keep lines under 100 characters
- Use meaningful variable and function names
- Add type annotations where supported

### Imports
- Group imports: standard library, third-party, local
- Sort imports alphabetically within groups
- Use absolute imports over relative when possible

### Error Handling
- Handle errors explicitly, don't ignore them
- Use appropriate error types for the language
- Log errors with sufficient context

### Naming Conventions
- Use camelCase for JavaScript/TypeScript
- Use snake_case for Python/Rust
- Use PascalCase for types/classes
- Use UPPER_CASE for constants

### Documentation
- Add docstrings/comments for public APIs
- Keep comments concise and up-to-date
- Use README.md for project-level documentation

## Notes
- This is a minimal repository - update this file as the project grows
- Add language-specific linting/formatting tools as needed