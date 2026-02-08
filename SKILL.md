---
name: native-ios-app
description: Build native iOS apps with SwiftUI using Xcode 26.3 MCP integration and Ralph OG autonomous development. Use when creating iOS apps, Swift development, Xcode projects, or autonomous mobile app development with visual design styles.
version: 1.0.0
allowed-tools: Bash(xcrun *), Bash(xcodebuild *), Bash(npx xcodebuildmcp *), Bash(swift *), Read, Write, Edit, Glob, Grep
---

# Native iOS App Development Skill

Build native iOS applications using SwiftUI, Xcode 26.3 MCP integration, and Ralph OG autonomous development loops.

## Quick Reference

| Command | Purpose |
|---------|---------|
| `/native-ios-app init "App Name"` | Initialize new iOS project |
| `/native-ios-app ralph "objective"` | Start Ralph OG autonomous loop |
| `/native-ios-app style glassmorphism` | Apply design style to project |
| `/native-ios-app build` | Build project via MCP |
| `/native-ios-app preview` | Capture SwiftUI previews |
| `/native-ios-app status` | Check build/test status |

---

## Prerequisites

### 1. Xcode 26.3+ Setup

Enable MCP bridge in Xcode:
1. Xcode → Settings → Intelligence → Anthropic (configure API key)
2. Xcode → Settings → Intelligence → Model Context Protocol → Enable "Xcode Tools"

### 2. MCP Bridge for Claude Code

```bash
# Add Xcode MCP bridge
claude mcp add --transport stdio xcode -- xcrun mcpbridge

# Verify
claude mcp list
```

### 3. XcodeBuildMCP (Enhanced Features)

```bash
npm install -g xcodebuildmcp@beta
claude mcp add XcodeBuildMCP -- npx -y xcodebuildmcp@beta mcp
```

---

## Xcode MCP Tools Available

Once configured, these tools are available:

| Category | Tools |
|----------|-------|
| **File Ops** | XcodeRead, XcodeWrite, XcodeUpdate, XcodeGlob, XcodeGrep, XcodeLS, XcodeMakeDir, XcodeRM, XcodeMV |
| **Build** | BuildProject, GetBuildLog |
| **Testing** | RunAllTests, RunSomeTests, GetTestList |
| **Analysis** | XcodeListNavigatorIssues, XcodeRefreshCodeIssuesInFile |
| **Preview** | RenderPreview (SwiftUI → PNG images) |
| **Execute** | ExecuteSnippet (Swift REPL) |
| **Docs** | DocumentationSearch (Apple docs + WWDC transcripts) |
| **Navigation** | XcodeListWindows |

---

## Project Initialization

### Create New iOS App

```bash
# Create project directory
mkdir -p ~/Developer/MyApp
cd ~/Developer/MyApp

# Initialize Xcode project (via swift package or Xcode template)
swift package init --type executable --name MyApp
```

### Project Structure

```
MyApp/
├── MyApp.xcodeproj/
├── MyApp/
│   ├── MyAppApp.swift          # App entry point
│   ├── ContentView.swift       # Main view
│   ├── Views/                  # SwiftUI views
│   ├── Models/                 # Data models
│   ├── ViewModels/             # MVVM view models
│   ├── Services/               # API/data services
│   ├── Components/             # Reusable UI components
│   └── Resources/              # Assets, colors, fonts
├── MyAppTests/
├── .ralph-og/                  # Ralph OG autonomous loop
└── .design-system/             # Design tokens and styles
```

---

## Ralph OG Integration for iOS

### Initialize Ralph OG for iOS Development

Creates `.ralph-og/` with iOS-specific configuration:

```
.ralph-og/
├── PROMPT.md              # Xcode-aware loop prompt
├── init.sh                # Swift/Xcode environment setup
├── feature-list.json      # Atomic features with SwiftUI focus
├── progress.txt           # Work log
├── loop.sh                # The autonomous loop
└── learnings.md           # iOS-specific learnings
```

### iOS-Specific PROMPT.md

The Ralph OG prompt for iOS includes:

1. **Startup Ritual**:
   - `pwd` - Confirm directory
   - Read `.ralph-og/progress.txt`
   - `git log --oneline -10`
   - Read `.ralph-og/feature-list.json`
   - `xcodebuild -list` - Verify schemes
   - Check for Xcode open via MCP

2. **Visual Verification**:
   - Capture SwiftUI Previews after UI changes
   - Compare with expected layouts

3. **Build Verification**:
   - `xcodebuild build` before marking complete
   - Check for warnings/errors

4. **Test Verification**:
   - Run tests via `xcodebuild test`

### Starting the Loop

```bash
cd ~/Developer/MyApp
.ralph-og/loop.sh
```

Or in background:
```bash
nohup .ralph-og/loop.sh > .ralph-og/loop.log 2>&1 &
echo $! > .ralph-og/loop.pid
```

---

## Design Styles

Select a visual design language for your app. Each style includes SwiftUI implementation patterns.

### Available Styles

See [styles/README.md](styles/README.md) for complete catalog:

| Style | Best For |
|-------|----------|
| **Liquid Glass** | iOS 26+ apps, modern Apple aesthetic |
| **Glassmorphism** | Overlays, cards, modals |
| **Neumorphism** | Tactile buttons, soft interfaces |
| **Flat Design** | Clean, minimal interfaces |
| **Material Design** | Android-like, cross-platform |
| **Brutalism** | Bold, high-contrast, statement apps |
| **Neo-Brutalism** | Modern brutalist with color |
| **Minimalism** | Content-focused, clean |
| **Cyberpunk** | Dark mode, neon accents |
| **Retro/Y2K** | Nostalgic, playful |
| **Bento Box** | Grid layouts, organized content |

### Applying a Style

```
/native-ios-app style glassmorphism
```

This creates `.design-system/tokens.swift` with style-specific:
- Color palette
- Typography scale
- Spacing system
- Shadow definitions
- Corner radius tokens
- Animation curves

---

## SwiftUI Materials & Effects

### iOS 15+ Native Materials

```swift
// Available material types
.ultraThinMaterial      // Most transparent
.thinMaterial
.regularMaterial
.thickMaterial
.ultraThickMaterial     // Most opaque

// Usage
Text("Hello")
    .padding()
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
```

### Liquid Glass (iOS 26+)

```swift
// New in iOS 26: Liquid Glass effect
.background(.liquidGlass)
.glassEffect(style: .standard)
.glassEffect(style: .frosted, tint: .blue)
```

### Custom Blur Effects

```swift
struct GlassCard: View {
    var body: some View {
        ZStack {
            // Background blur
            Rectangle()
                .fill(.ultraThinMaterial)

            // Content
            VStack {
                Text("Glass Card")
                    .font(.headline)
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}
```

---

## Commands Reference

### `/native-ios-app init "App Name"`

Initialize a new iOS project:
1. Create Xcode project structure
2. Set up SwiftUI app template
3. Configure build settings
4. Initialize git repository
5. Create `.design-system/` with default tokens
6. Optionally initialize Ralph OG

### `/native-ios-app ralph "objective"`

Start Ralph OG autonomous development:
1. Create `.ralph-og/` directory
2. Generate iOS-specific PROMPT.md
3. Create feature-list.json from objective
4. Set up init.sh with Swift toolchain checks
5. Start the loop

### `/native-ios-app style <style-name>`

Apply design style:
1. Read style definition from `styles/<style-name>.md`
2. Generate `.design-system/tokens.swift`
3. Create style-specific SwiftUI extensions
4. Update existing components if present

### `/native-ios-app build`

Build via Xcode MCP:
1. Check for open Xcode project
2. Run `BuildProject` via MCP
3. Report build status and errors
4. Capture any warnings

### `/native-ios-app preview`

Capture SwiftUI previews:
1. List preview providers in project
2. Render each via `RenderPreview` MCP tool
3. Save PNG images to `.previews/`
4. Report any preview failures

### `/native-ios-app status`

Check project status:
1. Build state (last build time, success/failure)
2. Test results (passed/failed/skipped)
3. Code issues from navigator
4. Ralph OG progress (if active)

---

## Best Practices

### SwiftUI Architecture

Use MVVM pattern:
```
Views/           → SwiftUI views (display only)
ViewModels/      → @Observable classes (logic)
Models/          → Data structures
Services/        → API, persistence
```

### Design Token Usage

Always use tokens, never hardcoded values:
```swift
// Good
Text("Title")
    .font(.system(size: DesignTokens.Typography.title))
    .foregroundColor(DesignTokens.Colors.textPrimary)

// Bad
Text("Title")
    .font(.system(size: 28))
    .foregroundColor(Color(hex: "#1a1a1a"))
```

### Accessibility

- Minimum touch target: 44×44pt
- Support Dynamic Type
- Provide accessibility labels
- Respect `reduceMotion` preference

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

.animation(reduceMotion ? nil : .spring(), value: isExpanded)
```

---

## Troubleshooting

### MCP Bridge Not Working

1. Verify Xcode 26.3+ installed: `xcodebuild -version`
2. Check MCP enabled in Xcode Settings
3. Ensure Xcode is running with project open
4. Test with: `xcrun mcpbridge --help`

### Build Failures

1. Check scheme: `xcodebuild -list`
2. Clean build folder: `xcodebuild clean`
3. Check signing: Xcode → Project → Signing & Capabilities

### Preview Not Rendering

1. Ensure preview provider exists
2. Check for compile errors
3. Verify simulator selected in Xcode

---

## Resources

### Apple Documentation
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [Xcode 26.3 Release Notes](https://developer.apple.com/documentation/xcode-release-notes/)

### References in This Skill
- [references/xcode-mcp-tools.md](references/xcode-mcp-tools.md) - Complete MCP tool reference
- [references/swiftui-patterns.md](references/swiftui-patterns.md) - Common SwiftUI patterns
- [references/ralph-ios.md](references/ralph-ios.md) - Ralph OG iOS configuration
- [styles/README.md](styles/README.md) - Design style catalog

### Templates
- [templates/PROMPT.ios.template.md](templates/PROMPT.ios.template.md) - iOS Ralph prompt
- [templates/feature-list.ios.template.json](templates/feature-list.ios.template.json) - iOS features template
- [templates/init.ios.template.sh](templates/init.ios.template.sh) - iOS environment setup

---

*Skill Version: 1.0.0*
*Compatible with: Xcode 26.3+, iOS 17+, Swift 5.9+*
