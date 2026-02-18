# How to Build Your Design System in JoJoPlayground

> A step-by-step record of building a design system from scratch using the JoJoPlayground starter kit. Follow along to build your own.

---

## How This Playbook Works

This playbook documents every phase of building a design system — from adding fonts to shipping flows. Each phase is updated with the exact steps taken as the work is completed, so it doubles as a reusable guide for other designers.

**Status markers:**
- **Not started** — Phase hasn't been touched yet
- **In progress** — Currently working on this phase
- **Done** — Completed with full step-by-step instructions

**Project files you'll touch:**

| Phase | Key Files |
|-------|-----------|
| Fonts | `Fonts/`, `Info.plist` |
| Colors | `DesignSystem/Tokens/DSColors.swift` |
| Typography | `DesignSystem/Tokens/DSTypography.swift` |
| Spacing | `DesignSystem/Tokens/DSSpacing.swift` |
| Icons & Images | `Assets.xcassets/`, `DesignSystem/Tokens/DSIcons.swift` |
| Components | `DesignSystem/Components/` |
| Flows | `Features/` |

All paths are relative to `JoJoPlayground/`.

---

## Phase 1: Fonts

Add your custom font files so the design system can reference them.

> **Status: Done**

### What was done

1. Added **9 static Lexend Deca font files** to `Fonts/`:
   - `LexendDeca-Thin.ttf`, `LexendDeca-ExtraLight.ttf`, `LexendDeca-Light.ttf`, `LexendDeca-Regular.ttf`, `LexendDeca-Medium.ttf`, `LexendDeca-SemiBold.ttf`, `LexendDeca-Bold.ttf`, `LexendDeca-ExtraBold.ttf`, `LexendDeca-Black.ttf`
2. Registered all 9 fonts in `Info.plist` under `UIAppFonts` using **filenames only** (no `Fonts/` prefix — Xcode's filesystem sync copies files flat into the bundle root)
3. Set `INFOPLIST_FILE = JoJoPlayground/Info.plist` in both Debug and Release build configurations so Xcode merges custom keys (like `UIAppFonts`) into the generated Info.plist
4. Verified fonts appear in **Build Phases > Copy Bundle Resources** in Xcode
5. Built and confirmed all 3 used weights render correctly: Light, Regular, Medium

### Why static fonts instead of variable font

The variable font (`LexendDeca-VariableFont_wght.ttf`) exposes only one PostScript name (`LexendDeca-Regular`). SwiftUI's `Font.custom()` needs distinct PostScript names per weight. Static font files each have their own PostScript name (`LexendDeca-Light`, `LexendDeca-Regular`, `LexendDeca-Medium`), so `DSTypography.swift` works directly without workarounds.

### Troubleshooting notes

**"A build only device cannot be used to run this target"**
You have "Any iOS Device (arm64)" selected. Click the device selector in the Xcode toolbar (top center, next to the scheme name) and pick a **Simulator** (e.g., iPhone 16 Pro). Then Cmd+R again.

**"Multiple commands produce '...Info.plist'" or "'..._README.md'"**
This happens with Xcode 16+ filesystem sync (`PBXFileSystemSynchronizedRootGroup`) when non-code files collide in the app bundle. Fix: open **Build Phases > Copy Bundle Resources** and remove the conflicting files, or delete `_README.md` files from the source tree since they are documentation only.

**Font doesn't appear (system font shows instead)**
Three things must all be correct:
1. **Info.plist filenames** — use filenames only (e.g., `LexendDeca-Regular.ttf`), NOT paths with `Fonts/` prefix. Xcode's filesystem sync copies resources flat into the bundle root.
2. **INFOPLIST_FILE build setting** — must be set to `JoJoPlayground/Info.plist` in target build settings (both Debug and Release). Without this, `GENERATE_INFOPLIST_FILE = YES` causes Xcode to ignore the custom Info.plist entirely, and `UIAppFonts` won't be in the bundled plist.
3. **Copy Bundle Resources** — verify font files appear in Build Phases > Copy Bundle Resources. If not, close and reopen the Xcode project to force a filesystem re-sync, or add them manually via the "+" button.
- After any fix: Clean Build Folder (Cmd+Shift+K) and rebuild

---

## Phase 2: Colors

Define your color palette as tokens in `DSColors.swift`.

> **Status: Done**

### What was done

1. Extracted all color tokens from the Figma design system file using the Figma MCP variable definitions (node `16:120682`)
2. Added **46 color tokens** to `DSColors.swift`, organized into 9 categories:
   - **Primitives** (6): Black, White, Blue/600, Red/600, Yellow/300, Green/600
   - **Background** (3): backgroundPrimary, backgroundSecondary, backgroundTertiary
   - **Content** (3): contentPrimary, contentSecondary, contentTertiary
   - **Border** (2): borderOpaque, borderSelected
   - **Inverse** (7): backgroundInversePrimary/Secondary, contentInversePrimary/Secondary/Tertiary, borderInverseOpaque/Selected
   - **Background Extensions** (11): state, accent, negative, warning, positive variants + light variants + always dark/light
   - **Content Extensions** (7): state, onColor, accent, negative, warning, positive variants
   - **Border Extensions** (6): state, accent, negative, warning, positive variants + accent light
   - **Programs** (7): safety, eats, freight, rewardsTier2/3/4, membership
3. Used the existing `Color(hex:)` extension for all hex-based color definitions

---

## Phase 3: Typography

Define type styles in `DSTypography.swift` using the fonts from Phase 1.

> **Status: Done**

### What was done

1. Extracted all typography tokens from the Figma design system file (node `16:123388`)
2. Added 3 PostScript name constants for Lexend Deca variable font weights:
   - `LexendDeca-Light` (Light / 300)
   - `LexendDeca-Regular` (Regular / 400)
   - `LexendDeca-Medium` (Medium / 500)
3. Added **7 type styles** to `DSTypography.swift`, each with a `Font` and `lineHeight`:
   - **title**: Medium, 36px / 44px — screen titles, primary headings
   - **bodyEmphasized**: Medium, 18px / 28px — emphasized body text, section titles
   - **bodyRegular**: Regular, 18px / 28px — body text, descriptions
   - **accentEmphasized**: Medium, 14px / 16px — emphasized labels, captions
   - **accentRegular**: Regular, 14px / 16px — secondary labels, captions
   - **accentLight**: Light, 14px / 16px — tertiary labels, subtle text
   - **accentSmall**: Regular, 12px / 16px — fine print, timestamps, badges

### Verification needed

- Build the app in Xcode and check the console output from the debug font printer in `JoJoPlaygroundApp.swift`
- Confirm the PostScript names match (`LexendDeca-Light`, `LexendDeca-Regular`, `LexendDeca-Medium`)
- If names differ, update the private constants in `DSTypography.swift`

---

## Phase 4: Spacing

Define your spacing scale in `DSSpacing.swift`.

> **Status: Done**

### What was done

1. Extracted all spacing tokens from the Figma design system file (node `16:120432`)
2. Added **17 spacing tokens** to `DSSpacing.swift` using Figma naming convention:
   - `none` = 0pt (for explicit zero-spacing, e.g., `VStack(spacing: DSSpacing.none)`)
   - `s2` = 2pt, `s4` = 4pt, `s8` = 8pt, `s12` = 12pt, `s16` = 16pt
   - `s20` = 20pt, `s24` = 24pt, `s28` = 28pt, `s32` = 32pt, `s36` = 36pt
   - `s40` = 40pt, `s48` = 48pt, `s56` = 56pt, `s64` = 64pt, `s96` = 96pt, `s128` = 128pt

---

## Foundation Complete (Phases 1–4)

Fonts, colors, typography, and spacing are all defined. The design system foundation is ready for use.

**Summary of what was built:**
- **9 static fonts** registered: Lexend Deca (3 weights used: Light, Regular, Medium; all 9 weights available)
- **46 color tokens** in `DSColors.swift` across 9 categories, extracted from Figma variables
- **7 type styles** in `DSTypography.swift`, each with a `Font` and `lineHeight`
- **17 spacing tokens** in `DSSpacing.swift` using Figma naming (`s2`–`s128` + `none`)

**Documentation updated:**
- Token reference tables in `SPEC.md` (Section 5)
- Token reference in `CLAUDE.md` (so the AI validates token usage)

**How Figma data was extracted:**
- Colors: `get_variable_defs` on the Color page node — returned all hex values as structured data
- Typography: `get_design_context` on the Typography frame — returned font family, weight, size, and line height
- Spacing: `get_design_context` on the Spacing frame — returned spacer sizes and Figma token names
- Tip: If a Figma node is too large for `get_design_context`, try `get_variable_defs` instead — it returns variable values without the full layout code

**Next:** ~~Build components (Phase 6) or add assets (Phase 5)~~ Phase 5 (Icons & Images) is now done. Next: build components (Phase 6), then assemble flows (Phase 7).

---

## Phase 5: Icons & Images

Export assets from Figma and add them to the asset catalog.

> **Status: Done**

### What was done

1. Extracted the **icon size spec** from Figma (node `17:122664`), which defines 4 icon sizes: 24px, 20px, 16px, 14px
2. Exported **8 custom icons** from Figma as PDF vectors and added them to `Assets.xcassets`:
   - **24px:** `arrow_left` (back arrow)
   - **20px:** `Search`, `User`, `Shopping cart`, `Map pin`, `Home`
   - **16px:** `Close icon`
   - **14px:** `circle_exclamation_point` (error indicator)
3. Exported **3 images** as PNGs and added them to `Assets.xcassets`:
   - `DS.Image` — placeholder image component
   - `HomeBG` — home screen background
   - `SearchBG` — search screen background
4. Configured all icon image sets with:
   - **Single Scale** (PDF vectors, no 1x/2x/3x needed)
   - **Template Image** rendering (tintable via `foregroundStyle`)
   - **Preserve Vector Data** enabled (clean scaling at any size)
5. Created **`DSIcons.swift`** in `DesignSystem/Tokens/` with:
   - Type-safe `Image` references for all 8 icons (e.g., `DSIcons.arrowLeft`)
   - 4 size constants matching the Figma spec: `sizeLarge` (24), `sizeMedium` (20), `sizeSmall` (16), `sizeXSmall` (14)
   - `DSImages` enum for the 3 raster images (e.g., `DSImages.homeBG`)

### How to use icons in code

```swift
// Icon at its Figma-spec size, tinted with a design token color
DSIcons.arrowLeft
    .resizable()
    .frame(width: DSIcons.sizeLarge, height: DSIcons.sizeLarge)
    .foregroundStyle(DSColors.contentPrimary)

// Tab bar icon
DSIcons.home
    .resizable()
    .frame(width: DSIcons.sizeMedium, height: DSIcons.sizeMedium)
    .foregroundStyle(DSColors.contentSecondary)
```

### How to use images in code

```swift
// Background image
DSImages.homeBG
    .resizable()
    .aspectRatio(contentMode: .fill)
```

### Adding more icons later

1. Export from Figma as **PDF** at 1x
2. Drag into `Assets.xcassets` in Xcode
3. Set: Single Scale, Template Image, Preserve Vector Data
4. Add a `static let` to `DSIcons` in `DSIcons.swift`
5. Update the token reference in `SPEC.md` and `CLAUDE.md`

---

## Phase 6: Components

Build reusable `DS`-prefixed components from your design system.

> **Status: Done**

### What was done

1. Built **4 design system components** in `DesignSystem/Components/`, all from Figma designs:
   - **`DSButton.swift`** — Primary action button with 3 states: Default, Pressed (white 20% overlay), Disabled (gray). Uses custom `ButtonStyle` for press detection. All states use `bodyRegular` font.
   - **`DSTitle.swift`** — Large title header (36px Medium, 44px line height). Supports multi-line wrapping with no truncation.
   - **`DSSwitch.swift`** — Toggle switch with On/Off states and 3-layer animation: spring thumb slide, track color crossfade, thumb stretch effect (28pt to 34pt), plus haptic feedback.
   - **`DSListItem.swift`** — Two-line list item (label + paragraph) with optional right-side control via `@ViewBuilder`. Includes bottom divider with 16pt left inset.

2. Created **`ComponentCatalogView.swift`** in `DesignSystem/` — scrollable showcase of all 4 components in all states, with custom back button using `DSIcons.arrowLeft`.

3. Rewrote **`ContentView.swift`** as the **landing page** (Figma node `22:5873`):
   - 96pt top spacer, `DSTitle("👋 JoJoPlayground")`, `DSListItem` placeholder, 64pt gap
   - 4 buttons: 2 primary (`DSButton`), 1 green (`backgroundPositive`), 1 yellow (`backgroundWarning`)
   - Only the last button ("Components Catalog") navigates to `ComponentCatalogView`
   - Wrapped in `NavigationStack` with system nav bar hidden

### Component API reference

```swift
// DSButton — primary action button
DSButton(label: "Label", action: { })
DSButton(label: "Disabled", action: { }, isDisabled: true)

// DSTitle — large title
DSTitle("Screen Title")

// DSSwitch — toggle with animation
@State private var isOn = false
DSSwitch(isOn: $isOn)

// DSListItem — with optional control
DSListItem(label: "Label", paragraph: "Description") {
    DSSwitch(isOn: $isOn)
}
DSListItem(label: "Label", paragraph: "Description")  // no control
```

---

## Phase 7: Flows

Assemble components into full user flows. See [FLOW_TEMPLATE.md](FLOW_TEMPLATE.md) for the code template.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

---

## Final Step

Token tables in [SPEC.md](SPEC.md) (Section 5) and [CLAUDE.md](CLAUDE.md) are already updated for Phases 1–5. Update them again if you add new tokens, components, or assets in later phases.
