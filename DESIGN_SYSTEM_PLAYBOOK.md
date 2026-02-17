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

- Remove the debug font printer from `JoJoPlaygroundApp.swift` once no longer needed
- Proceed to Phase 3 (Typography) to wire the PostScript name into `DSTypography.swift`

---

## Phase 2: Colors

Define your color palette as tokens in `DSColors.swift`.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

---

## Phase 3: Typography

Define type styles in `DSTypography.swift` using the fonts from Phase 1.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

---

## Phase 4: Spacing

Define your spacing scale in `DSSpacing.swift`.

> **Status: Not started**

*Steps will be documented here as this phase is completed.*

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

Once all phases are done, update the token tables in [SPEC.md](SPEC.md) (Section 5) so the AI knows your complete design system.
