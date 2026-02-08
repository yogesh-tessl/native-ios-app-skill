# Xcode MCP Tools Reference

Complete reference for Xcode 26.3 Model Context Protocol tools.

## Setup

### Enable MCP in Xcode

1. Open Xcode 26.3+
2. Xcode → Settings → Intelligence
3. Configure Anthropic API key
4. Model Context Protocol → Enable "Xcode Tools"

### Add to Claude Code

```bash
# Add Xcode MCP bridge
claude mcp add --transport stdio xcode -- xcrun mcpbridge

# Verify
claude mcp list

# Check loaded tools
/context
```

## How It Works

The `xcrun mcpbridge` binary translates MCP protocol requests into Xcode's internal XPC calls. The bridge automatically detects the running Xcode process—no manual PID specification needed.

Agents call `XcodeListWindows` first to discover open projects and retrieve the `tabIdentifier` needed for subsequent tool invocations.

---

## Available Tools (20 Total)

### File Operations

#### XcodeRead
Read file contents from Xcode project.

```json
{
  "tool": "XcodeRead",
  "arguments": {
    "tabIdentifier": "<from XcodeListWindows>",
    "path": "Sources/MyApp/ContentView.swift"
  }
}
```

#### XcodeWrite
Create or overwrite a file.

```json
{
  "tool": "XcodeWrite",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/NewFile.swift",
    "content": "import SwiftUI\n\nstruct NewView: View { ... }"
  }
}
```

#### XcodeUpdate
Update specific portions of a file.

```json
{
  "tool": "XcodeUpdate",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/ContentView.swift",
    "updates": [
      {
        "lineStart": 10,
        "lineEnd": 15,
        "content": "// Updated code"
      }
    ]
  }
}
```

#### XcodeGlob
Find files matching a pattern.

```json
{
  "tool": "XcodeGlob",
  "arguments": {
    "tabIdentifier": "<id>",
    "pattern": "**/*.swift"
  }
}
```

#### XcodeGrep
Search file contents.

```json
{
  "tool": "XcodeGrep",
  "arguments": {
    "tabIdentifier": "<id>",
    "pattern": "class.*ViewModel",
    "path": "Sources/"
  }
}
```

#### XcodeLS
List directory contents.

```json
{
  "tool": "XcodeLS",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/"
  }
}
```

#### XcodeMakeDir
Create a directory.

```json
{
  "tool": "XcodeMakeDir",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/Components"
  }
}
```

#### XcodeRM
Remove file or directory.

```json
{
  "tool": "XcodeRM",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/OldFile.swift"
  }
}
```

#### XcodeMV
Move or rename file.

```json
{
  "tool": "XcodeMV",
  "arguments": {
    "tabIdentifier": "<id>",
    "from": "Sources/MyApp/OldName.swift",
    "to": "Sources/MyApp/NewName.swift"
  }
}
```

---

### Build & Testing

#### BuildProject
Build the project for specified destination.

```json
{
  "tool": "BuildProject",
  "arguments": {
    "tabIdentifier": "<id>",
    "scheme": "MyApp",
    "destination": "platform=iOS Simulator,name=iPhone 15 Pro"
  }
}
```

**Returns:**
- Build success/failure status
- Build duration
- Warnings and errors

#### GetBuildLog
Retrieve build log from last build.

```json
{
  "tool": "GetBuildLog",
  "arguments": {
    "tabIdentifier": "<id>"
  }
}
```

#### RunAllTests
Run all tests in the project.

```json
{
  "tool": "RunAllTests",
  "arguments": {
    "tabIdentifier": "<id>",
    "scheme": "MyAppTests",
    "destination": "platform=iOS Simulator,name=iPhone 15 Pro"
  }
}
```

#### RunSomeTests
Run specific tests.

```json
{
  "tool": "RunSomeTests",
  "arguments": {
    "tabIdentifier": "<id>",
    "tests": [
      "MyAppTests/ContentViewTests/testInitialState",
      "MyAppTests/ViewModelTests"
    ]
  }
}
```

#### GetTestList
List all available tests.

```json
{
  "tool": "GetTestList",
  "arguments": {
    "tabIdentifier": "<id>",
    "scheme": "MyAppTests"
  }
}
```

---

### Code Analysis

#### XcodeListNavigatorIssues
Get all issues from the Issue Navigator.

```json
{
  "tool": "XcodeListNavigatorIssues",
  "arguments": {
    "tabIdentifier": "<id>"
  }
}
```

**Returns:**
- Errors
- Warnings
- Static analyzer issues
- File locations

#### XcodeRefreshCodeIssuesInFile
Force refresh issues for a specific file.

```json
{
  "tool": "XcodeRefreshCodeIssuesInFile",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/ContentView.swift"
  }
}
```

---

### Execution & Preview

#### RenderPreview
Render a SwiftUI preview as an image.

```json
{
  "tool": "RenderPreview",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/ContentView.swift",
    "previewName": "ContentView_Previews"
  }
}
```

**Returns:**
- Base64-encoded PNG image
- Preview dimensions
- Device frame info

This is essential for visual verification in Ralph OG loops.

#### ExecuteSnippet
Execute Swift code in REPL environment.

```json
{
  "tool": "ExecuteSnippet",
  "arguments": {
    "tabIdentifier": "<id>",
    "code": "let result = 2 + 2\nprint(result)"
  }
}
```

---

### Documentation

#### DocumentationSearch
Search Apple documentation and WWDC transcripts.

```json
{
  "tool": "DocumentationSearch",
  "arguments": {
    "query": "SwiftUI NavigationStack"
  }
}
```

**Returns:**
- Documentation excerpts
- WWDC session references
- API documentation links

---

### Navigation

#### XcodeListWindows
List all open Xcode windows and projects.

```json
{
  "tool": "XcodeListWindows",
  "arguments": {}
}
```

**Returns:**
```json
{
  "windows": [
    {
      "tabIdentifier": "abc123",
      "projectName": "MyApp",
      "projectPath": "/Users/dev/MyApp/MyApp.xcodeproj"
    }
  ]
}
```

Always call this first to get `tabIdentifier` for other tools.

---

## XcodeBuildMCP (Enhanced CLI)

Alternative MCP server with additional features.

### Installation

```bash
npm install -g xcodebuildmcp@beta
claude mcp add XcodeBuildMCP -- npx -y xcodebuildmcp@beta mcp
```

### CLI Commands

```bash
# Start MCP server
xcodebuildmcp mcp

# List available tools
xcodebuildmcp tools

# Build for simulator
xcodebuildmcp simulator build-sim \
  --scheme MyApp \
  --project-path ./MyApp.xcodeproj

# Run tests
xcodebuildmcp test \
  --scheme MyAppTests \
  --destination "platform=iOS Simulator,name=iPhone 15 Pro"
```

### Additional Capabilities

- Swift macro validation handling
- Code signing utilities
- Simulator management
- Device operations
- Per-workspace daemon for stateful operations

---

## Workflow Example

### 1. Discover Project

```json
{"tool": "XcodeListWindows"}
```

### 2. Explore Structure

```json
{
  "tool": "XcodeLS",
  "arguments": {"tabIdentifier": "<id>", "path": "Sources/"}
}
```

### 3. Read Existing Code

```json
{
  "tool": "XcodeRead",
  "arguments": {"tabIdentifier": "<id>", "path": "Sources/MyApp/ContentView.swift"}
}
```

### 4. Search Documentation

```json
{
  "tool": "DocumentationSearch",
  "arguments": {"query": "SwiftUI @Observable macro"}
}
```

### 5. Write New Code

```json
{
  "tool": "XcodeWrite",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/NewFeature.swift",
    "content": "..."
  }
}
```

### 6. Build

```json
{
  "tool": "BuildProject",
  "arguments": {"tabIdentifier": "<id>", "scheme": "MyApp"}
}
```

### 7. Check Issues

```json
{"tool": "XcodeListNavigatorIssues", "arguments": {"tabIdentifier": "<id>"}}
```

### 8. Preview

```json
{
  "tool": "RenderPreview",
  "arguments": {
    "tabIdentifier": "<id>",
    "path": "Sources/MyApp/NewFeature.swift"
  }
}
```

### 9. Test

```json
{
  "tool": "RunAllTests",
  "arguments": {"tabIdentifier": "<id>", "scheme": "MyAppTests"}
}
```

---

## Troubleshooting

### MCP Not Loading

1. Verify Xcode version: `xcodebuild -version` (need 26.3+)
2. Check MCP enabled in Xcode Settings
3. Ensure project is open in Xcode
4. Restart Claude Code session

### Tools Not Found

Run `/context` in Claude Code to see loaded MCP tools. Look for warnings about excluded skills.

### Build Failures

1. Check scheme exists: `xcodebuild -list`
2. Verify simulator: `xcrun simctl list devices`
3. Check signing configuration

### Preview Not Rendering

1. Ensure preview provider exists in file
2. Check for compile errors first
3. Select valid simulator in Xcode

---

## Sources

- [Xcode 26.3 + Claude Agent](https://fatbobman.com/en/posts/xcode-263-claude)
- [Using Xcode MCP Tools in Claude Code](https://rudrank.com/exploring-xcode-using-mcp-tools-cursor-external-clients)
- [XcodeBuildMCP GitHub](https://github.com/cameroncooke/XcodeBuildMCP)
- [Apple Xcode + Claude Agent SDK](https://www.anthropic.com/news/apple-xcode-claude-agent-sdk)
