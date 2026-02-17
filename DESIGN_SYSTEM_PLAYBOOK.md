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
| Icons & Images | `Assets.xcassets/` |
| Components | `DesignSystem/Components/` |
| Flows | `Features/` |

All paths are relative to `JoJoPlayground/`.

---

## Phase 1: Fonts

Add your custom font files so the design system can reference them.

> **Status: Done**

### What was done

1. Added **Lexend Deca** (variable weight) to `Fonts/LexendDeca-VariableFont_wght.ttf`
2. Registered the font in `Info.plist` under `UIAppFonts` with path `Fonts/LexendDeca-VariableFont_wght.ttf`
3. Added a temporary `#if DEBUG` font printer in `JoJoPlaygroundApp.swift` to verify the font loads and discover its PostScript name
4. Built and confirmed the font loads successfully

### Troubleshooting notes

**"A build only device cannot be used to run this target"**
You have "Any iOS Device (arm64)" selected. Click the device selector in the Xcode toolbar (top center, next to the scheme name) and pick a **Simulator** (e.g., iPhone 16 Pro). Then Cmd+R again.

**"Multiple commands produce '...Info.plist'" or "'..._README.md'"**
This happens with Xcode 15+ filesystem sync (`PBXFileSystemSynchronizedRootGroup`) when non-code files collide in the app bundle. Fix: open **Build Phases > Copy Bundle Resources** and remove the conflicting files, or delete `_README.md` files from the source tree since they are documentation only.

**Font doesn't appear (system font shows instead)**
- Verify the filename in `Info.plist` matches exactly (case-sensitive), including the `Fonts/` prefix
- Clean Build Folder (Cmd+Shift+K) and rebuild
- Use the `#if DEBUG` font printer in `JoJoPlaygroundApp.swift` to check if the font family appears in the console

### Next

- Remove the debug font printer from `JoJoPlaygroundApp.swift` once PostScript names are verified

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
- **1 font** registered: Lexend Deca (variable weight, 3 weights used: Light, Regular, Medium)
- **46 color tokens** in `DSColors.swift` across 9 categories, extracted from Figma variables
- **7 type styles** in `DSTypography.swift`, each with a `Font` and `lineHeight`
- **17 spacing tokens** in `DSSpacing.swift` using Figma naming (`s2`–`s128` + `none`)

**Documentation updated:**
- Token reference tables in `SPEC.md` (Section 5)
- Token reference in `.cursor/rules/jojoplayground.mdc` (so the AI validates token usage)

**How Figma data was extracted:**
- Colors: `get_variable_defs` on the Color page node — returned all hex values as structured data
- Typography: `get_design_context` on the Typography frame — returned font family, weight, size, and line height
- Spacing: `get_design_context` on the Spacing frame — returned spacer sizes and Figma token names
- Tip: If a Figma node is too large for `get_design_context`, try `get_variable_defs` instead — it returns variable values without the full layout code

**Next:** Build components (Phase 6) or add assets (Phase 5), then assemble flows (Phase 7).

---

## Phase 5: Icons & Images

Export assets from Figma and add them to the asset catalog.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

---

## Phase 6: Components

Build reusable `DS`-prefixed components from your design system.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

---

## Phase 7: Flows

Assemble components into full user flows. See [FLOW_TEMPLATE.md](FLOW_TEMPLATE.md) for the code template.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

---

## Final Step

Token tables in [SPEC.md](SPEC.md) (Section 5) and [.cursor/rules/jojoplayground.mdc](.cursor/rules/jojoplayground.mdc) are already updated for Phases 1–4. Update them again if you add new tokens, components, or assets in later phases.
