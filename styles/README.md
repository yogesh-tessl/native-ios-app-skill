# Design Styles Catalog

Complete catalog of visual design styles with SwiftUI implementation patterns.

## Style Selection Guide

| Style | Mood | Best For | Complexity |
|-------|------|----------|------------|
| Liquid Glass | Modern, Premium | iOS 26+ apps | Medium |
| Glassmorphism | Airy, Futuristic | Overlays, cards | Medium |
| Neumorphism | Soft, Tactile | Buttons, controls | Low |
| Flat Design | Clean, Simple | Content-first apps | Low |
| Semi-Flat (Flat 2.0) | Balanced, Modern | Most apps | Low |
| Material Design | Systematic, Cross-platform | Android parity | Medium |
| Gradient Design | Vibrant, Dynamic | Marketing apps | Medium |
| Brutalism | Raw, Bold | Statement apps | Low |
| Neo-Brutalism | Playful, High-contrast | Creative apps | Medium |
| Swiss/International | Precise, Grid-based | Typography-focused | Medium |
| Memphis Design | Playful, 80s | Youth-focused | High |
| Claymorphism | 3D, Soft | Playful interfaces | High |
| Dark Mode Aesthetic | Immersive, Premium | Media, content | Low |
| Cyberpunk/Futurism | Neon, Tech | Gaming, tech apps | High |
| Minimalism | Quiet, Focused | Productivity | Low |
| Bauhaus | Geometric, Functional | Design tools | Medium |
| Retro/Vintage | Nostalgic, Warm | Lifestyle apps | Medium |
| Y2K Design | Nostalgic, Bold | Gen Z apps | High |
| Organic/Natural UI | Soft, Biomorphic | Wellness apps | Medium |
| Editorial/Magazine | Typography-rich | Reading apps | Medium |
| Illustration-Driven | Personality, Fun | Consumer apps | High |
| Motion-First | Dynamic, Engaging | Interactive apps | High |
| Data-Dense/Analytical | Information-rich | Dashboards | Medium |
| Bento Box | Organized, Grid | Modular content | Low |
| Skeuomorphism | Realistic, Familiar | Specialty tools | High |

---

## Detailed Style Definitions

### 1. Liquid Glass (iOS 26+)

Apple's new design language in iOS 26. Evolution of glassmorphism with realistic light refraction.

**Characteristics:**
- Translucency with soft gradients
- Realistic light play and refraction
- Dynamic layering with depth
- Smooth, intentional edges

**SwiftUI Implementation:**
```swift
// iOS 26+ native support
.background(.liquidGlass)
.glassEffect(style: .standard)

// Custom implementation for earlier versions
struct LiquidGlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .overlay(
                LinearGradient(
                    colors: [.white.opacity(0.15), .clear],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}
```

**Color Palette:**
- Background: Dynamic blur of underlying content
- Overlay: White 10-20% opacity
- Text: High contrast (white on dark, black on light)
- Accents: System tints

**When to Use:**
- Modern iOS apps targeting 26+
- Premium app feel
- Content that benefits from seeing through layers

---

### 2. Glassmorphism

Frosted glass aesthetic with blur and transparency.

**Characteristics:**
- Semi-transparent backgrounds
- Frosted blur effect
- Subtle borders
- Floating appearance

**SwiftUI Implementation:**
```swift
struct GlassmorphicCard: View {
    var body: some View {
        VStack {
            // Content
        }
        .padding()
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}
```

**Color Palette:**
- Background: Blur with 70-90% opacity
- Border: White 20% opacity
- Text: White or high-contrast dark
- Shadows: Soft, diffuse

**When to Use:**
- Overlay panels
- Modal sheets
- Cards over colorful backgrounds

---

### 3. Neumorphism (Soft UI)

Soft, extruded elements that appear pressed into or out of the surface.

**Characteristics:**
- Monochromatic backgrounds
- Dual shadows (light + dark)
- Soft, pillowy appearance
- Subtle depth

**SwiftUI Implementation:**
```swift
struct NeumorphicButton: View {
    @State private var isPressed = false
    let backgroundColor = Color(hex: "#e0e5ec")

    var body: some View {
        Button(action: {}) {
            Image(systemName: "heart.fill")
                .font(.title)
                .foregroundColor(.gray)
        }
        .padding(20)
        .background(backgroundColor)
        .clipShape(Circle())
        .shadow(color: .white, radius: 8, x: -6, y: -6)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 6, y: 6)
    }
}
```

**Color Palette:**
- Base: Light gray (#e0e5ec) or dark equivalent
- Light shadow: White or lighter shade
- Dark shadow: 20% black or darker shade
- Accents: Muted pastels

**When to Use:**
- Audio/music controls
- Settings toggles
- Minimalist interfaces

**Caution:** Low contrast can cause accessibility issues. Test thoroughly.

---

### 4. Flat Design

Pure 2D elements with solid colors and no depth effects.

**Characteristics:**
- No shadows or gradients
- Solid color fills
- Simple geometric shapes
- High readability

**SwiftUI Implementation:**
```swift
struct FlatButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Get Started")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
```

**Color Palette:**
- Bold, saturated colors
- Limited palette (4-6 colors)
- High contrast combinations

**When to Use:**
- Content-first apps
- Fast-loading interfaces
- High accessibility requirements

---

### 5. Semi-Flat / Flat 2.0

Flat design with subtle depth cues.

**Characteristics:**
- Mostly flat with minimal shadows
- Subtle gradients allowed
- Thin borders for definition
- Clean but not sterile

**SwiftUI Implementation:**
```swift
struct SemiFlatCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Card Title")
                .font(.headline)
            Text("Description")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}
```

---

### 6. Material Design 3

Google's design system with dynamic color and tonal surfaces.

**Characteristics:**
- Tonal elevation (color, not shadow)
- Dynamic color from content
- Large touch targets (48dp)
- Predictable motion

**SwiftUI Implementation:**
```swift
struct MaterialCard: View {
    var body: some View {
        VStack {
            // Content
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
        // M3 uses tonal elevation, not shadow
    }
}
```

---

### 7. Brutalism / Digital Brutalism

Raw, unpolished aesthetic with heavy contrast.

**Characteristics:**
- Heavy black borders
- Stark color contrasts
- Blocky layouts
- Intentional roughness

**SwiftUI Implementation:**
```swift
struct BrutalistButton: View {
    var body: some View {
        Button(action: {}) {
            Text("CLICK ME")
                .font(.system(size: 18, weight: .black))
                .foregroundColor(.black)
                .padding()
                .background(Color.yellow)
                .border(Color.black, width: 4)
                .offset(x: -4, y: -4)
        }
        .background(Color.black)
    }
}
```

**Color Palette:**
- Black + one bold accent
- High saturation
- No gradients

---

### 8. Neo-Brutalism / Neubrutalism

Modern brutalism with playful colors and softer edges.

**Characteristics:**
- Bold, high-contrast colors
- Thick borders (2-4px)
- Intentionally misaligned shadows
- Blocky but playful

**SwiftUI Implementation:**
```swift
struct NeoBrutalistCard: View {
    var body: some View {
        VStack {
            Text("Hello")
                .font(.largeTitle.bold())
        }
        .padding(24)
        .background(Color(hex: "#90EE90")) // Lime green
        .border(Color.black, width: 3)
        .offset(x: 6, y: 6)
        .background(Color.black)
    }
}
```

**Color Palette:**
- Neon greens, pinks, yellows
- Pure black outlines
- White backgrounds

---

### 9. Cyberpunk / Futurism

Dark, neon-accented tech aesthetic.

**Characteristics:**
- Dark backgrounds
- Neon accent colors
- Glitch effects
- Futuristic typography

**SwiftUI Implementation:**
```swift
struct CyberpunkText: View {
    var body: some View {
        ZStack {
            Text("SYSTEM")
                .font(.system(size: 40, weight: .black))
                .foregroundColor(.cyan)
                .offset(x: 2, y: 2)
            Text("SYSTEM")
                .font(.system(size: 40, weight: .black))
                .foregroundColor(.magenta)
                .offset(x: -2, y: -2)
            Text("SYSTEM")
                .font(.system(size: 40, weight: .black))
                .foregroundColor(.white)
        }
    }
}
```

**Color Palette:**
- Background: Near-black (#0a0a0a)
- Accents: Cyan, magenta, electric blue
- Text: White or neon

---

### 10. Minimalism

Maximum restraint, focus on content.

**Characteristics:**
- Abundant white space
- Limited color palette
- Essential elements only
- Typography-focused

**SwiftUI Implementation:**
```swift
struct MinimalistList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ForEach(items) { item in
                HStack {
                    Text(item.title)
                        .font(.body)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
            }
            Divider()
        }
        .padding()
    }
}
```

**Color Palette:**
- Black, white, one accent
- Extensive use of system colors

---

### 11. Bauhaus

Geometric, functional design from the Bauhaus school.

**Characteristics:**
- Primary colors (red, yellow, blue)
- Geometric shapes
- Grid-based layouts
- Sans-serif typography

**SwiftUI Implementation:**
```swift
struct BauhausElement: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow)
                .frame(width: 100)
            Rectangle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(45))
            Circle()
                .fill(Color.red)
                .frame(width: 30)
        }
    }
}
```

---

### 12. Y2K Design

Late 90s/early 2000s nostalgia.

**Characteristics:**
- Chrome/metallic effects
- Holographic gradients
- Bubble letters
- Pixel elements

**SwiftUI Implementation:**
```swift
struct Y2KGradient: View {
    var body: some View {
        Text("Y2K VIBES")
            .font(.largeTitle.bold())
            .foregroundStyle(
                LinearGradient(
                    colors: [.purple, .blue, .cyan, .green],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}
```

---

### 13. Bento Box

Grid-based, compartmentalized layouts.

**Characteristics:**
- Modular grid sections
- Clear content separation
- Organized information
- Inspired by Apple marketing

**SwiftUI Implementation:**
```swift
struct BentoGrid: View {
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            BentoCell(size: .large)
            BentoCell(size: .small)
            BentoCell(size: .small)
            BentoCell(size: .medium)
        }
        .padding()
    }
}
```

---

### 14. Claymorphism

3D, clay-like soft elements.

**Characteristics:**
- Soft, rounded 3D appearance
- Pastel colors
- Multiple layered shadows
- Playful, friendly feel

**SwiftUI Implementation:**
```swift
struct ClaymorphicButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Press Me")
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "#f87171"))
                .shadow(color: Color(hex: "#f87171").opacity(0.5), radius: 20, y: 10)
                .shadow(color: .white.opacity(0.2), radius: 2, x: -2, y: -2)
        )
    }
}
```

---

### 15. Skeuomorphism

Realistic textures mimicking physical objects.

**Characteristics:**
- Realistic textures (leather, wood, metal)
- Physical metaphors
- Detailed shadows and highlights
- Familiar interfaces

**SwiftUI Implementation:**
```swift
struct SkeuomorphicToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        // Detailed implementation with gradients,
        // inner shadows, and texture overlays
        Toggle("", isOn: $isOn)
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .scaleEffect(1.2)
            .shadow(color: .black.opacity(0.2), radius: 2, y: 2)
    }
}
```

---

## Applying Styles

To apply a style to your project:

```
/native-ios-app style <style-name>
```

This generates:
1. `.design-system/tokens.swift` - Design tokens
2. `.design-system/extensions.swift` - SwiftUI extensions
3. Updates any existing components with new style

## Custom Style Definition

Create your own style in `styles/custom-style.md`:

```markdown
---
name: custom-style
---

# Custom Style

## Colors
primary: #HEX
secondary: #HEX
background: #HEX
surface: #HEX
text-primary: #HEX
text-secondary: #HEX
accent: #HEX

## Typography
font-family: SF Pro
title-size: 28
body-size: 17
caption-size: 13

## Spacing
base: 8
scale: [4, 8, 12, 16, 24, 32, 48]

## Borders
radius-sm: 8
radius-md: 12
radius-lg: 20

## Shadows
shadow-sm: 0 1px 3px rgba(0,0,0,0.08)
shadow-md: 0 4px 12px rgba(0,0,0,0.1)

## Motion
duration-fast: 200ms
duration-normal: 300ms
easing: cubic-bezier(0.4, 0, 0.2, 1)
```

---

## Sources

- [iOS 26 Liquid Glass UI](https://www.designmonks.co/blog/liquid-glass-ui)
- [Glassmorphism UI Best Practices](https://uxpilot.ai/blogs/glassmorphism-ui)
- [UI Trends: Neumorphism vs Glassmorphism vs Neubrutalism](https://www.cccreative.design/blogs/differences-in-ui-design-trends-neumorphism-glassmorphism-and-neubrutalism)
- [Graphic Design Styles Guide 2026](https://www.magier.com/blog/graphic-design-styles)
- [Mobile App Design Trends 2026](https://uxpilot.ai/blogs/mobile-app-design-trends)
- [Neobrutalism Definition - NN/g](https://www.nngroup.com/articles/neobrutalism/)
