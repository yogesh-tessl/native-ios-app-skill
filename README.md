# Native iOS App Skill

Build native iOS applications using SwiftUI, Xcode 26.3 MCP integration, and Ralph OG autonomous development loops.

## Features

- **Xcode 26.3 MCP Integration**: Use Xcode tools directly from Claude Code CLI
- **Ralph OG Autonomous Development**: Run unattended iOS development loops
- **25+ Design Styles**: Glassmorphism, Neumorphism, Brutalism, and more
- **SwiftUI Best Practices**: MVVM, @Observable, NavigationStack patterns
- **Visual Verification**: Capture SwiftUI previews during development

## Installation

### Global (Personal Skills)

```bash
# Clone this skill
git clone https://github.com/YOUR_USERNAME/native-ios-app-skill.git

# Copy to Claude Code skills directory
cp -r native-ios-app-skill ~/.claude/skills/native-ios-app
```

### Via Claude Code Plugin

```bash
# Add as plugin
/plugin install native-ios-app@YOUR_USERNAME/native-ios-app-skill
```

## Prerequisites

### 1. Xcode 26.3+

Enable MCP in Xcode:
1. Settings → Intelligence → Anthropic (configure API key)
2. Settings → Intelligence → Model Context Protocol → Enable "Xcode Tools"

### 2. MCP Bridge

```bash
claude mcp add --transport stdio xcode -- xcrun mcpbridge
claude mcp list  # Verify
```

### 3. XcodeBuildMCP (Optional)

```bash
npm install -g xcodebuildmcp@beta
claude mcp add XcodeBuildMCP -- npx -y xcodebuildmcp@beta mcp
```

## Usage

### Initialize a New Project

```
/native-ios-app init "MyApp"
```

### Start Autonomous Development

```
/native-ios-app ralph "Build a todo app with categories and dark mode"
```

### Apply a Design Style

```
/native-ios-app style glassmorphism
```

### Build and Preview

```
/native-ios-app build
/native-ios-app preview
```

## Design Styles

25+ design styles with SwiftUI implementations:

| Style | Description |
|-------|-------------|
| Liquid Glass | iOS 26+ native glass effect |
| Glassmorphism | Frosted glass with blur |
| Neumorphism | Soft, embossed elements |
| Flat Design | Clean, 2D elements |
| Material Design | Google's design system |
| Brutalism | Raw, high-contrast |
| Neo-Brutalism | Playful brutalist |
| Minimalism | Essential elements only |
| Cyberpunk | Dark with neon accents |
| Y2K | 2000s nostalgia |
| Bento Box | Grid-based layouts |

See `styles/README.md` for complete catalog with SwiftUI code.

## Directory Structure

```
native-ios-app/
├── SKILL.md                          # Main skill definition
├── README.md                         # This file
├── references/
│   └── xcode-mcp-tools.md           # Xcode MCP reference
├── templates/
│   ├── PROMPT.ios.template.md       # Ralph OG prompt
│   ├── feature-list.ios.template.json
│   └── init.ios.template.sh
├── scripts/
│   └── loop.ios.sh                  # Autonomous loop script
└── styles/
    └── README.md                    # Design styles catalog
```

## Ralph OG Integration

This skill uses the [Ralph OG technique](https://ghuntley.com/ralph/) for autonomous development:

1. **Fresh context per iteration**: Each loop starts with clean context
2. **State via files**: Progress tracked in `feature-list.json` and `progress.txt`
3. **Atomic features**: One feature per iteration
4. **Build verification**: Xcode build must succeed before completion

### How It Works

```
┌─────────────────────────────────────────────────────┐
│  Ralph OG Loop (fresh context each iteration)       │
├─────────────────────────────────────────────────────┤
│  1. Read progress.txt - what's done                 │
│  2. Read feature-list.json - what's next            │
│  3. Pick highest priority failing feature           │
│  4. Implement with SwiftUI                          │
│  5. Build project (via xcodebuild or MCP)           │
│  6. Run tests if applicable                         │
│  7. Commit changes                                  │
│  8. Update progress.txt                             │
│  9. Exit → loop restarts with fresh context         │
└─────────────────────────────────────────────────────┘
```

## License

MIT

## Sources

- [Apple Xcode + Claude Agent SDK](https://www.anthropic.com/news/apple-xcode-claude-agent-sdk)
- [Xcode 26.3 Agentic Coding](https://www.apple.com/newsroom/2026/02/xcode-26-point-3-unlocks-the-power-of-agentic-coding/)
- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)
- [Ralph OG Technique](https://ghuntley.com/ralph/)
- [XcodeBuildMCP](https://github.com/cameroncooke/XcodeBuildMCP)
