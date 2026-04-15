---
name: native-ios-app
description: "Create and develop native iOS applications with SwiftUI, configure Xcode MCP tools, scaffold project structures, apply visual design styles, run autonomous build-test-commit loops, and capture SwiftUI previews. Use when building an iPhone app, writing .swift files, setting up an Xcode project, designing app UI, running iOS simulators, or automating iOS development workflows."
allowed-tools: Bash(xcrun *), Bash(xcodebuild *), Bash(npx xcodebuildmcp *), Bash(swift *), Read, Write, Edit, Glob, Grep
---

# Native iOS App Development Skill

Create and develop native iOS applications using SwiftUI and Xcode MCP integration, with optional autonomous development loops for hands-off feature implementation.

## Quick Reference

| Command | Purpose |
|---------|---------|
| `/native-ios-app init "App Name"` | Scaffold new iOS project with SwiftUI template |
| `/native-ios-app ralph "objective"` | Start autonomous build-test-commit loop |
| `/native-ios-app style glassmorphism` | Apply design style and generate tokens |
| `/native-ios-app build` | Build project via Xcode MCP |
| `/native-ios-app preview` | Capture SwiftUI preview screenshots |
| `/native-ios-app status` | Check build, test, and loop status |

---

## Prerequisites

### 1. Xcode MCP Bridge Setup

1. Xcode → Settings → Intelligence → Anthropic (configure API key)
2. Xcode → Settings → Intelligence → Model Context Protocol → Enable "Xcode Tools"

```bash
claude mcp add --transport stdio xcode -- xcrun mcpbridge
claude mcp list  # verify bridge loaded
```

### 2. XcodeBuildMCP (Enhanced CLI Features)

```bash
npm install -g xcodebuildmcp@beta
claude mcp add XcodeBuildMCP -- npx -y xcodebuildmcp@beta mcp
```

---

## Xcode MCP Tools Available

Once configured, these tools are available via MCP. See [references/xcode-mcp-tools.md](references/xcode-mcp-tools.md) for full parameters and usage examples.

| Category | Tools |
|----------|-------|
| **File Ops** | XcodeRead, XcodeWrite, XcodeUpdate, XcodeGlob, XcodeGrep, XcodeLS, XcodeMakeDir, XcodeRM, XcodeMV |
| **Build** | BuildProject, GetBuildLog |
| **Testing** | RunAllTests, RunSomeTests, GetTestList |
| **Analysis** | XcodeListNavigatorIssues, XcodeRefreshCodeIssuesInFile |
| **Preview** | RenderPreview (SwiftUI → PNG images) |
| **Execute** | ExecuteSnippet (Swift REPL) |
| **Docs** | DocumentationSearch (Apple docs + WWDC transcripts) |
| **Navigation** | XcodeListWindows (call first to get `tabIdentifier`) |

---

## Project Initialization (`/native-ios-app init`)

1. Create project directory and Xcode project structure
2. Set up SwiftUI app template with `@main` entry point
3. Configure build settings for target iOS version
4. Initialize git repository
5. Create `.design-system/` with default design tokens
6. **Verify**: Run `xcodebuild build` — must succeed before proceeding
7. **If build fails**: Check scheme with `xcodebuild -list`, verify signing in Xcode → Project → Signing & Capabilities

### Standard Project Structure

```
MyApp/
├── MyApp.xcodeproj/
├── MyApp/
│   ├── MyAppApp.swift          # @main entry point
│   ├── ContentView.swift       # Main view
│   ├── Views/                  # SwiftUI views
│   ├── Models/                 # Data structures
│   ├── ViewModels/             # @Observable classes
│   ├── Services/               # API/persistence
│   ├── Components/             # Reusable UI components
│   └── Resources/              # Assets, colors, fonts
├── MyAppTests/
└── .design-system/             # Design tokens and styles
```

---

## Autonomous Development Loop (`/native-ios-app ralph`)

The Ralph OG loop autonomously picks features from a task list and implements them one at a time with full build verification, test runs, and commits.

### Setup

Creates `.ralph-og/` with iOS-specific configuration:

| File | Purpose |
|------|---------|
| `PROMPT.md` | Loop prompt with startup ritual and rules — see [templates/PROMPT.ios.template.md](templates/PROMPT.ios.template.md) |
| `feature-list.json` | Atomic features with acceptance criteria — see [templates/feature-list.ios.template.json](templates/feature-list.ios.template.json) |
| `init.sh` | Environment verification — see [templates/init.ios.template.sh](templates/init.ios.template.sh) |
| `loop.sh` | Autonomous loop runner — see [scripts/loop.ios.sh](scripts/loop.ios.sh) |
| `progress.txt` | Work log tracking completed features |

### Loop Workflow (each iteration)

1. **Startup**: Read `progress.txt`, check `git log --oneline -10`, verify schemes with `xcodebuild -list`
2. **Pick**: Select highest-priority incomplete feature from `feature-list.json`
3. **Implement**: Build the feature using SwiftUI
4. **Build**: Run `xcodebuild build` — must succeed before marking complete
   - **If build fails** → Read error output → fix issues → rebuild. Do not proceed until green.
5. **Test**: Run `xcodebuild test` if tests exist
   - **If tests fail** → Fix failing tests → re-run. Never delete or modify existing tests.
6. **Preview**: Capture SwiftUI previews via `RenderPreview` for visual verification
7. **Commit**: `git commit` with descriptive message
8. **Log**: Update `progress.txt` with completed feature

### Starting the Loop

```bash
# Foreground
.ralph-og/loop.sh

# Background
nohup .ralph-og/loop.sh > .ralph-og/loop.log 2>&1 &
echo $! > .ralph-og/loop.pid
```

---

## Design Styles (`/native-ios-app style`)

Apply a visual design language to the project. See [styles/README.md](styles/README.md) for the complete catalog with SwiftUI implementation patterns.

| Style | Best For |
|-------|----------|
| **Liquid Glass** | iOS 26+ apps, modern Apple aesthetic |
| **Glassmorphism** | Overlays, cards, modals |
| **Neumorphism** | Tactile buttons, soft interfaces |
| **Flat Design** | Clean, minimal interfaces |
| **Brutalism** | Bold, high-contrast, statement apps |
| **Neo-Brutalism** | Modern brutalist with color |
| **Minimalism** | Content-focused, clean |
| **Cyberpunk** | Dark mode, neon accents |
| **Bento Box** | Grid layouts, organized content |

Running `/native-ios-app style <name>` generates:
1. `.design-system/tokens.swift` — colors, typography, spacing, shadows, corner radii, animation curves
2. `.design-system/extensions.swift` — SwiftUI view extensions for the chosen style
3. Updates existing components if present

Always use design tokens instead of hardcoded values:

```swift
// Correct — uses tokens
Text("Title")
    .font(.system(size: DesignTokens.Typography.title))
    .foregroundColor(DesignTokens.Colors.textPrimary)

// Incorrect — hardcoded values
Text("Title")
    .font(.system(size: 28))
    .foregroundColor(Color(hex: "#1a1a1a"))
```

---

## Build and Preview Commands

### `/native-ios-app build`

1. Discover open project via `XcodeListWindows` to get `tabIdentifier`
2. Run `BuildProject` via MCP with target scheme
3. **If build succeeds** → Report status and any warnings
4. **If build fails** → Run `GetBuildLog` → identify errors → suggest fixes
5. **If MCP unavailable** → Fall back to `xcodebuild build -scheme <scheme>`

### `/native-ios-app preview`

1. Find preview providers with `XcodeGlob` for `*_Previews` types
2. Render each via `RenderPreview` → save PNG to `.previews/`
3. **If preview fails** → Check compile errors with `XcodeListNavigatorIssues` first, then verify simulator is selected

### `/native-ios-app status`

Reports build state (last result, warnings), test results (passed/failed/skipped), navigator issues, and Ralph OG loop progress if active.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP bridge not working | Verify Xcode 26.3+ with `xcodebuild -version`. Check MCP enabled in Xcode Settings. Ensure project is open. Test: `xcrun mcpbridge --help` |
| Build failures | Check scheme: `xcodebuild -list`. Clean: `xcodebuild clean`. Verify signing: Xcode → Project → Signing & Capabilities |
| Preview not rendering | Confirm preview provider exists. Check compile errors first. Verify simulator selected in Xcode |

---

## Resources

- [references/xcode-mcp-tools.md](references/xcode-mcp-tools.md) — Complete MCP tool reference with parameters and examples
- [styles/README.md](styles/README.md) — Design style catalog with SwiftUI implementation patterns
- [templates/](templates/) — Ralph OG iOS templates (prompt, feature list, init script)
- [scripts/loop.ios.sh](scripts/loop.ios.sh) — Autonomous loop runner script
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
