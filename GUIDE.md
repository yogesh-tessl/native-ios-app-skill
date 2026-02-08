# Native iOS App Development Guide

A complete guide to building native iOS apps with Claude Code using Xcode 26.3 MCP integration and Ralph OG autonomous development.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Prerequisites](#prerequisites)
3. [MCP Setup](#mcp-setup)
4. [Commands Reference](#commands-reference)
5. [Design Styles](#design-styles)
6. [Ralph OG Autonomous Development](#ralph-og-autonomous-development)
7. [SwiftUI Best Practices](#swiftui-best-practices)
8. [Troubleshooting](#troubleshooting)

---

## Quick Start

### 30-Second Start

```bash
# 1. Create a new iOS app
/native-ios-app init "MyApp"

# 2. Apply a design style
/native-ios-app style glassmorphism

# 3. Start autonomous development
/native-ios-app ralph "Build a todo app with categories and dark mode"
```

### Manual Workflow

```bash
# Navigate to your project
cd ~/Developer/MyApp

# Build for simulator
xcodebuildmcp simulator build-sim \
  --workspace-path ./MyApp.xcworkspace \
  --scheme MyApp \
  --simulator-name "iPhone 17 Pro"

# Run on simulator
xcodebuildmcp simulator build-run-sim \
  --workspace-path ./MyApp.xcworkspace \
  --scheme MyApp \
  --simulator-name "iPhone 17 Pro"

# Take a screenshot
xcodebuildmcp ui-automation screenshot \
  --simulator-id "<SIMULATOR_ID>" \
  --return-format path
```

---

## Prerequisites

### Required Software

| Software | Version | Check Command |
|----------|---------|---------------|
| macOS | 15.6+ | `sw_vers` |
| Xcode | 26.3+ | `xcodebuild -version` |
| Node.js | 18+ | `node --version` |
| Claude Code | Latest | `claude --version` |

### Xcode Setup

1. **Install Xcode 26.3** from [Apple Developer Downloads](https://developer.apple.com/download/applications)

2. **Set active developer directory**:
   ```bash
   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
   ```

3. **Enable MCP in Xcode**:
   - Open Xcode → Settings → Intelligence
   - Configure Anthropic API key
   - Model Context Protocol → Enable "Xcode Tools"

4. **Accept license** (if needed):
   ```bash
   sudo xcodebuild -license accept
   ```

---

## MCP Setup

### Option 1: Native Xcode MCP Bridge (Xcode 26.3+)

```bash
# Add native bridge
claude mcp add --transport stdio xcode -- xcrun mcpbridge

# Verify
claude mcp list
```

**Available Tools (20):**

| Category | Tools |
|----------|-------|
| File Ops | XcodeRead, XcodeWrite, XcodeUpdate, XcodeGlob, XcodeGrep, XcodeLS, XcodeMakeDir, XcodeRM, XcodeMV |
| Build | BuildProject, GetBuildLog |
| Test | RunAllTests, RunSomeTests, GetTestList |
| Analysis | XcodeListNavigatorIssues, XcodeRefreshCodeIssuesInFile |
| Preview | RenderPreview |
| Execute | ExecuteSnippet |
| Docs | DocumentationSearch |
| Navigation | XcodeListWindows |

### Option 2: XcodeBuildMCP (Works with Xcode 16+)

```bash
# Install globally
npm install -g xcodebuildmcp@beta

# Add to Claude Code
claude mcp add XcodeBuildMCP -- npx -y xcodebuildmcp@beta mcp

# Verify
claude mcp list
```

**Available Tools (90):** Build, test, debug, UI automation, logging, and more.

### Using Both (Recommended)

You can use both MCP servers together. They complement each other:
- **Native bridge**: SwiftUI previews, Apple documentation search
- **XcodeBuildMCP**: UI automation, debugging, video recording

---

## Commands Reference

### `/native-ios-app init "App Name"`

Creates a new iOS project with SwiftUI.

**What it does:**
1. Creates project directory structure
2. Generates Xcode project with SwiftUI app template
3. Sets up MVVM architecture folders
4. Initializes git repository
5. Creates `.design-system/` with default tokens

**Example:**
```
/native-ios-app init "TaskManager"
```

**Output structure:**
```
TaskManager/
├── TaskManager.xcodeproj/
├── TaskManager.xcworkspace/
├── TaskManager/
│   ├── TaskManagerApp.swift
│   ├── ContentView.swift
│   ├── Views/
│   ├── ViewModels/
│   ├── Models/
│   └── Services/
├── TaskManagerTests/
├── .design-system/
│   └── tokens.swift
└── .gitignore
```

---

### `/native-ios-app ralph "objective"`

Starts Ralph OG autonomous development loop.

**What it does:**
1. Creates `.ralph-og/` directory with iOS-specific templates
2. Generates `feature-list.json` from your objective
3. Sets up `PROMPT.md` for the coding agent
4. Starts the autonomous bash loop

**Example:**
```
/native-ios-app ralph "Build a habit tracker with daily reminders, streak counting, and statistics charts"
```

**How it works:**
```
┌─────────────────────────────────────────────────────┐
│              Ralph OG Loop (Fresh Context)          │
├─────────────────────────────────────────────────────┤
│  1. Read progress.txt → understand what's done      │
│  2. Read feature-list.json → find next task         │
│  3. Pick highest priority failing feature           │
│  4. Implement with SwiftUI                          │
│  5. Build project (verify no errors)                │
│  6. Run tests (if applicable)                       │
│  7. Commit changes                                  │
│  8. Update progress.txt                             │
│  9. Exit → loop restarts with fresh context         │
└─────────────────────────────────────────────────────┘
```

**Monitoring:**
```bash
# Check status
/native-ios-app status

# View progress
cat .ralph-og/progress.txt

# View feature list
cat .ralph-og/feature-list.json

# Watch logs (if running in background)
tail -f .ralph-og/loop.log
```

**Stopping:**
```bash
# Stop the loop
/native-ios-app cancel

# Or manually
kill $(cat .ralph-og/loop.pid)
```

---

### `/native-ios-app style <style-name>`

Applies a visual design style to your project.

**Available Styles:**

| Style | Description | Best For |
|-------|-------------|----------|
| `liquid-glass` | iOS 26+ native glass | Modern Apple aesthetic |
| `glassmorphism` | Frosted glass blur | Overlays, cards |
| `neumorphism` | Soft embossed UI | Buttons, controls |
| `flat` | Clean 2D elements | Content-first apps |
| `material` | Google's M3 design | Cross-platform |
| `brutalism` | Raw, high-contrast | Statement apps |
| `neo-brutalism` | Playful brutalist | Creative apps |
| `minimalism` | Essential elements | Productivity |
| `cyberpunk` | Dark + neon | Gaming, tech |
| `y2k` | 2000s nostalgia | Youth-focused |
| `bento` | Grid layouts | Modular content |

**Example:**
```
/native-ios-app style glassmorphism
```

**What it generates:**

`.design-system/tokens.swift`:
```swift
import SwiftUI

enum DesignTokens {
    enum Colors {
        static let primary = Color("Primary")
        static let secondary = Color("Secondary")
        static let background = Color("Background")
        static let surface = Color("Surface")
        static let textPrimary = Color("TextPrimary")
        static let textSecondary = Color("TextSecondary")
    }

    enum Typography {
        static let largeTitle: CGFloat = 34
        static let title1: CGFloat = 28
        static let title2: CGFloat = 22
        static let headline: CGFloat = 17
        static let body: CGFloat = 17
        static let caption: CGFloat = 12
    }

    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }

    enum Radius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 20
        static let full: CGFloat = 9999
    }
}
```

---

### `/native-ios-app build`

Builds the project via MCP.

**Example:**
```
/native-ios-app build
```

**Options:**
```
/native-ios-app build --scheme MyApp
/native-ios-app build --destination simulator
/native-ios-app build --destination device
```

---

### `/native-ios-app preview`

Captures SwiftUI previews as images.

**Example:**
```
/native-ios-app preview
```

**What it does:**
1. Finds all preview providers in the project
2. Renders each using `RenderPreview` MCP tool
3. Saves PNG images to `.previews/`
4. Reports any failures

---

### `/native-ios-app status`

Shows project and development status.

**Example:**
```
/native-ios-app status
```

**Output:**
```
Project: MyApp
Xcode: 26.3 (17C519)
Scheme: MyApp

Build Status: Success (2 min ago)
Test Results: 12 passed, 0 failed
Issues: 0 errors, 2 warnings

Ralph OG: Active
  Iteration: 7
  Features: 4/6 complete
  Current: "Add settings screen"
```

---

## Design Styles

### Glassmorphism

Frosted glass effect with blur and transparency.

```swift
struct GlassCard: View {
    var body: some View {
        VStack {
            Text("Glass Card")
                .font(.headline)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}
```

### Neumorphism

Soft, embossed elements.

```swift
struct NeumorphicButton: View {
    let bgColor = Color(red: 0.88, green: 0.89, blue: 0.93)

    var body: some View {
        Button(action: {}) {
            Image(systemName: "heart.fill")
                .font(.title)
                .foregroundColor(.gray)
        }
        .padding(20)
        .background(bgColor)
        .clipShape(Circle())
        .shadow(color: .white, radius: 8, x: -6, y: -6)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 6, y: 6)
    }
}
```

### Liquid Glass (iOS 26+)

Apple's new design language.

```swift
struct LiquidGlassCard: View {
    var body: some View {
        VStack {
            Text("Liquid Glass")
        }
        .padding()
        .background(.liquidGlass)
        .glassEffect(style: .standard)
    }
}
```

### Neo-Brutalism

Bold, high-contrast with playful colors.

```swift
struct NeoBrutalistCard: View {
    var body: some View {
        VStack {
            Text("HELLO")
                .font(.largeTitle.bold())
        }
        .padding(24)
        .background(Color(hex: "#90EE90"))
        .border(Color.black, width: 3)
        .offset(x: 6, y: 6)
        .background(Color.black)
    }
}
```

See `styles/README.md` for all 25+ styles with complete SwiftUI implementations.

---

## Ralph OG Autonomous Development

### Philosophy

Ralph OG uses fresh context per iteration. Each loop cycle:
- Starts with a clean context window
- Reads state from files (not memory)
- Completes ONE atomic feature
- Commits and exits

This prevents context degradation over long sessions.

### Feature List Structure

`.ralph-og/feature-list.json`:
```json
{
  "objective": "Build a todo app",
  "features": [
    {
      "id": 1,
      "name": "App Entry Point",
      "description": "Create main App struct",
      "status": "passing",
      "priority": 1
    },
    {
      "id": 2,
      "name": "Todo Model",
      "description": "Create Todo data model with title, completed, date",
      "status": "failing",
      "priority": 2
    }
  ],
  "guardrails": [
    "Do not edit or remove existing tests",
    "Use MVVM architecture",
    "Build must succeed before marking complete"
  ]
}
```

### Best Practices

1. **Atomic Features**: Each feature should be completable in one iteration
2. **Clear Acceptance Criteria**: Define what "done" means
3. **Build Verification**: Feature isn't complete until build succeeds
4. **Commit Often**: One commit per feature

### When to Use Ralph OG

**Good for:**
- Well-defined objectives
- Greenfield projects
- Overnight/unattended work
- Tasks with automatic verification

**Not for:**
- Unclear requirements
- Tasks needing human judgment
- Production debugging
- Quick one-off changes

---

## SwiftUI Best Practices

### Architecture: MVVM

```
Views/           → SwiftUI views (display only)
ViewModels/      → @Observable classes (logic)
Models/          → Data structures
Services/        → API, persistence
```

### Modern SwiftUI (iOS 17+)

```swift
// Use @Observable instead of ObservableObject
@Observable
class TodoViewModel {
    var todos: [Todo] = []
    var isLoading = false

    func load() async {
        isLoading = true
        todos = await TodoService.fetch()
        isLoading = false
    }
}

// Use in views
struct TodoListView: View {
    @State private var viewModel = TodoViewModel()

    var body: some View {
        List(viewModel.todos) { todo in
            TodoRow(todo: todo)
        }
        .task {
            await viewModel.load()
        }
    }
}
```

### Navigation (iOS 16+)

```swift
// Use NavigationStack
NavigationStack {
    List(items) { item in
        NavigationLink(value: item) {
            ItemRow(item: item)
        }
    }
    .navigationDestination(for: Item.self) { item in
        ItemDetailView(item: item)
    }
}
```

### Accessibility

```swift
// Minimum touch targets
Button(action: {}) {
    Image(systemName: "plus")
}
.frame(minWidth: 44, minHeight: 44) // Apple minimum

// Support Dynamic Type
Text("Title")
    .font(.title)  // Scales automatically

// Reduce motion
@Environment(\.accessibilityReduceMotion) var reduceMotion

.animation(reduceMotion ? nil : .spring(), value: isExpanded)
```

### Design Token Usage

```swift
// Always use tokens
Text("Title")
    .font(.system(size: DesignTokens.Typography.title1))
    .foregroundColor(DesignTokens.Colors.textPrimary)

// Never hardcode
Text("Title")
    .font(.system(size: 28))  // ❌ Bad
    .foregroundColor(Color(hex: "#1a1a1a"))  // ❌ Bad
```

---

## Troubleshooting

### MCP Bridge Not Connecting

**Symptoms:** `xcrun mcpbridge` fails or times out

**Solutions:**
1. Verify Xcode version: `xcodebuild -version` (need 26.3+)
2. Check Xcode is running with a project open
3. Enable MCP in Xcode Settings → Intelligence
4. Restart Claude Code session

### Build Failures

**Symptoms:** Build fails with signing or scheme errors

**Solutions:**
```bash
# List available schemes
xcodebuild -list

# Check signing
open MyApp.xcodeproj  # Configure in Xcode

# Clean build
xcodebuild clean -scheme MyApp
```

### Simulator Not Found

**Symptoms:** "Device not found" errors

**Solutions:**
```bash
# List available simulators
xcrun simctl list devices available

# Boot a simulator
xcrun simctl boot "iPhone 17 Pro"

# Open Simulator app
open -a Simulator
```

### Ralph OG Stuck

**Symptoms:** Loop not progressing

**Solutions:**
1. Check progress.txt for errors
2. Verify feature-list.json is valid JSON
3. Look at recent git commits
4. Check loop.log for error messages

```bash
# Manual check
cat .ralph-og/progress.txt
git log --oneline -5
```

### Preview Not Rendering

**Symptoms:** RenderPreview returns error

**Solutions:**
1. Ensure preview provider exists in the file
2. Check for compile errors first
3. Verify simulator is selected in Xcode
4. Try building the project first

---

## Resources

### Official Documentation
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [Xcode 26.3 Release Notes](https://developer.apple.com/documentation/xcode-release-notes/xcode-26_3-release-notes)

### MCP References
- [XcodeBuildMCP GitHub](https://github.com/cameroncooke/XcodeBuildMCP)
- [Xcode MCP Integration Guide](https://fatbobman.com/en/posts/xcode-263-claude)

### Ralph OG
- [Original Ralph Technique](https://ghuntley.com/ralph/)
- [Anthropic Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)

### Claude Code Skills
- [Skills Documentation](https://code.claude.com/docs/en/skills)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)

---

*Guide Version: 1.0.0*
*Last Updated: February 7, 2026*
*Compatible with: Xcode 26.3+, iOS 17+, Swift 6.2+*
