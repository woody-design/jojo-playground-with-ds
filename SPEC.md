# JoJoPlayground — Specification

> Design system reference, architecture, and conventions for the JoJoPlayground starter pack.

---

## 1. Overview

JoJoPlayground is a SwiftUI iOS starter pack for prototyping user flows using your own design system. It comes with the architecture, conventions, and token structure pre-configured — add your design system tokens, fonts, and components to start building flows.

---

## 2. Terminology

Figma-friendly terms used throughout this project. Code equivalents shown in parentheses.

| Term | Definition | Code Equivalent |
|------|-----------|----------------|
| **Flow** | A multi-screen user journey | Folder under `Features/` with `NavigationStack` |
| **Screen / Frame** | A full-screen UI. "Screen" for the app, "frame" in Figma. Interchangeable. | SwiftUI `View` struct, maps to a Step enum case |
| **Page** | A tab in a Figma file containing multiple frames. Not an app concept. | N/A — Figma-only |
| **Component** | A reusable UI piece | Struct in `DesignSystem/Components/` with DS naming |
| **Overlay** | UI on top of a screen: modal, sheet, dialog | `.sheet()`, `.fullScreenCover()`, `.overlay()` |
| **Token** | A named design value: color, font, or spacing | `DSColors`, `DSTypography`, `DSSpacing` |
| **Asset** | An icon, image, or illustration | File in `Assets.xcassets/` |

**Hierarchy:** Flow > Screen (+ Overlays), built with Components, styled with Tokens, using Assets.

---

## 3. Architecture

### Pattern: MVVM + Flow Coordinators

```
┌─────────────────────────────────────────────┐
│ ContentView                                 │
│   @State var activeFlow: AppFlow?           │
│   ├── nil → landing view                    │
│   └── .myFlow → MyFlowFlow                 │
└─────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────┐
│ {FlowName}Flow (Flow Coordinator)           │
│   @State var viewModel                      │
│   NavigationStack(path: $viewModel.path)    │
│     .navigationDestination(for: Step.self)  │
│     .environment(viewModel)                 │
└─────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────┐
│ {FlowName}ViewModel (@Observable)           │
│   var path: [Step]                          │
│   // flow state, computed properties        │
│   // navigation actions                     │
└─────────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────────┐
│ Screen Views                                │
│   @Environment(ViewModel.self) var viewModel│
│   Uses DS tokens and components             │
└─────────────────────────────────────────────┘
```

- **Navigation:** `NavigationStack` with enum-based type-safe routing (iOS 16+)
- **State:** `@Observable` classes (iOS 17+), injected via `.environment(viewModel)`
- **Root routing:** `ContentView` uses `@State private var activeFlow: AppFlow?` — no nested NavigationStacks
- Each flow owns its own `NavigationStack`
- Flows receive `onDismiss: () -> Void` to return to root

---

## 4. Project Structure

```
JoJoPlayground/
├── JoJoPlayground.xcodeproj/
├── JoJoPlayground/
│   ├── JoJoPlaygroundApp.swift       # @main entry point
│   ├── ContentView.swift             # Root routing
│   ├── Info.plist                    # Font registration, display name
│   │
│   ├── Fonts/                        # Your custom font files (TTF/OTF)
│   │
│   ├── DesignSystem/
│   │   ├── Tokens/
│   │   │   ├── DSColors.swift        # Color tokens
│   │   │   ├── DSTypography.swift    # Typography tokens
│   │   │   ├── DSSpacing.swift       # Spacing tokens
│   │   │   └── DSIcons.swift         # Icon & image references + sizes
│   │   └── Components/              # DS-prefixed reusable components
│   │
│   ├── Assets.xcassets/              # Icons, images, illustrations
│   │
│   └── Features/
│       └── {FlowName}/
│           ├── {FlowName}Flow.swift
│           ├── {FlowName}ViewModel.swift
│           └── Views/
│               ├── FirstScreenView.swift
│               └── ...
│
├── CLAUDE.md                          # Claude Code AI rules
├── FLOW_TEMPLATE.md                  # How to add a new flow
├── SPEC.md                           # This file
└── README.md                         # Getting started guide
```

---

## 5. Design System Tokens

### 5.1 Colors (DSColors)

**Primitives**

| Token | Value | Usage |
|-------|-------|-------|
| `primitiveBlack` | `#000000` | Core black |
| `primitiveWhite` | `#FFFFFF` | Core white |
| `primitiveBlue600` | `#276EF1` | Core blue |
| `primitiveRed600` | `#DE1135` | Core red |
| `primitiveYellow300` | `#F6BC2F` | Core yellow |
| `primitiveGreen600` | `#0E8345` | Core green |

**Background**

| Token | Value | Usage |
|-------|-------|-------|
| `backgroundPrimary` | `#FFFFFF` | Default background |
| `backgroundSecondary` | `#F3F3F3` | Secondary background |
| `backgroundTertiary` | `#E8E8E8` | Tertiary background |

**Content**

| Token | Value | Usage |
|-------|-------|-------|
| `contentPrimary` | `#000000` | Primary text / icons |
| `contentSecondary` | `#4B4B4B` | Secondary text |
| `contentTertiary` | `#5E5E5E` | Tertiary text |

**Border**

| Token | Value | Usage |
|-------|-------|-------|
| `borderOpaque` | `#E8E8E8` | Default border |
| `borderSelected` | `#000000` | Selected / active border |

**Inverse**

| Token | Value | Usage |
|-------|-------|-------|
| `backgroundInversePrimary` | `#000000` | Dark background |
| `backgroundInverseSecondary` | `#282828` | Dark secondary background |
| `contentInversePrimary` | `#FFFFFF` | Text on dark background |
| `contentInverseSecondary` | `#DDDDDD` | Secondary text on dark |
| `contentInverseTertiary` | `#A6A6A6` | Tertiary text on dark |
| `borderInverseOpaque` | `#4B4B4B` | Border on dark background |
| `borderInverseSelected` | `#FFFFFF` | Selected border on dark |

**Background Extensions**

| Token | Value | Usage |
|-------|-------|-------|
| `backgroundStateDisabled` | `#F3F3F3` | Disabled state background |
| `backgroundAccent` | `#276EF1` | Accent background |
| `backgroundNegative` | `#DE1135` | Error / negative background |
| `backgroundWarning` | `#F6BC2F` | Warning background |
| `backgroundPositive` | `#0E8345` | Success background |
| `backgroundAccentLight` | `#EFF4FE` | Light accent background |
| `backgroundNegativeLight` | `#FFF0EE` | Light error background |
| `backgroundWarningLight` | `#FDF2DC` | Light warning background |
| `backgroundPositiveLight` | `#EAF6ED` | Light success background |
| `backgroundAlwaysDark` | `#000000` | Always dark (ignores theme) |
| `backgroundAlwaysLight` | `#FFFFFF` | Always light (ignores theme) |

**Content Extensions**

| Token | Value | Usage |
|-------|-------|-------|
| `contentStateDisabled` | `#A6A6A6` | Disabled content |
| `contentOnColor` | `#FFFFFF` | Text on colored background |
| `contentOnColorInverse` | `#000000` | Text on light colored background |
| `contentAccent` | `#276EF1` | Accent text / icon |
| `contentNegative` | `#DE1135` | Error text |
| `contentWarning` | `#9F6402` | Warning text |
| `contentPositive` | `#0E8345` | Success text |

**Border Extensions**

| Token | Value | Usage |
|-------|-------|-------|
| `borderStateDisabled` | `#F3F3F3` | Disabled border |
| `borderAccent` | `#276EF1` | Accent border |
| `borderNegative` | `#DE1135` | Error border |
| `borderWarning` | `#9F6402` | Warning border |
| `borderPositive` | `#0E8345` | Success border |
| `borderAccentLight` | `#CDDEFF` | Light accent border |

**Programs**

| Token | Value | Usage |
|-------|-------|-------|
| `programsSafety` | `#276EF1` | Safety program |
| `programsEats` | `#0E8345` | Eats program |
| `programsFreight` | `#0E1FC1` | Freight program |
| `programsRewardsTier2` | `#FFC043` | Rewards tier 2 |
| `programsRewardsTier3` | `#8FA3AD` | Rewards tier 3 |
| `programsRewardsTier4` | `#000000` | Rewards tier 4 |
| `programsMembership` | `#9F6402` | Membership program |

### 5.2 Typography (DSTypography)

Font family: **Lexend Deca** (variable weight)

| Token | Weight | Size | Line Height | Usage |
|-------|--------|------|-------------|-------|
| `title` | Medium | 36px | 44px | Screen titles, primary headings |
| `bodyEmphasized` | Medium | 18px | 28px | Emphasized body text, section titles |
| `bodyRegular` | Regular | 18px | 28px | Body text, descriptions |
| `accentEmphasized` | Medium | 14px | 16px | Emphasized labels, captions |
| `accentRegular` | Regular | 14px | 16px | Secondary labels, captions |
| `accentLight` | Light | 14px | 16px | Tertiary labels, subtle text |
| `accentSmall` | Regular | 12px | 16px | Fine print, timestamps, badges |

Each token has a corresponding `lineHeight` property (e.g., `DSTypography.titleLineHeight`).

### 5.3 Spacing (DSSpacing)

| Token | Value |
|-------|-------|
| `none` | 0pt |
| `s2` | 2pt |
| `s4` | 4pt |
| `s8` | 8pt |
| `s12` | 12pt |
| `s16` | 16pt |
| `s20` | 20pt |
| `s24` | 24pt |
| `s28` | 28pt |
| `s32` | 32pt |
| `s36` | 36pt |
| `s40` | 40pt |
| `s48` | 48pt |
| `s56` | 56pt |
| `s64` | 64pt |
| `s96` | 96pt |
| `s128` | 128pt |

---

## 6. Conventions

### Figma Conventions

*These are recommended best practices. They optimize the Figma-to-code workflow but are not strict requirements.*

#### Page Structure

Organize each Figma file into **3 pages**, ordered bottom-up from primitives to composition:

| Page | Contents | Why |
|------|----------|-----|
| **DS Components** | Reusable design system components (`DS.Button`, `DS.Input`, etc.) with all states/variants | Built first — maps to `DesignSystem/Components/` |
| **Custom Components - {FlowName}** | Flow-specific components not in the global design system | Built second — reusable within the flow |
| **Flow - {FlowName}** | All screens in navigation order, showing the complete user journey | Built last — assembles components into screens |

#### Component Naming

Figma DS components use **dot-slash hierarchy** for grouping:

| Figma Name | Code File | Mapping Rule |
|------------|-----------|--------------|
| `DS.Button / Standard` | `DSButton.swift` | Category becomes filename; variant (`Standard`) becomes a parameter or enum case |
| `DS.Input/DS.TextField` | `DSTextField.swift` | Deepest component name becomes the filename |

- The `DS.` prefix and slashes are for Figma organization — the code filename is always `DS{LeafName}.swift`
- Variants after ` / ` (e.g., `Standard`, `Destructive`) map to component parameters, not separate files

#### Layer Naming

Name layers that represent meaningful UI concepts. Skip generic layout wrappers.

| Layer Type | Name It? | Example |
|------------|----------|---------|
| Component instances | Yes | `DS.Button / Standard` |
| Screen frames (top-level) | Yes | `FirstScreenView - Default` |
| Images, icons, illustrations | Yes | `MyFlow-confirmation` (see Asset Naming below) |
| Semantic sections | Yes | `HeaderSection`, `CTASection` |
| Generic layout wrappers | No | `Frame 12`, `Group 3` — leave default |
| Decorative shapes | No | Rectangles, divider lines — leave default |
| Text layers | No | The visible text content is what matters |

#### Asset Naming

Name image/icon layers in Figma to match the **final asset name** before exporting:

```
Figma layer: "MyFlow-confirmation"
       ↓ export as PDF
Finder file: MyFlow-confirmation.pdf
       ↓ drag into Xcode
Assets.xcassets: MyFlow-confirmation
       ↓ reference in code
SwiftUI: Image("MyFlow-confirmation")
```

Convention: `{FlowName}-{description}` (e.g., `OrderCard-confirmation`, `Onboarding-welcome`)

#### State Variants

Append a state suffix to screen frames and component variants:

- ` - Default` — resting/initial state
- ` - Active` — focused or in-progress state
- ` - Disabled` — non-interactive state
- ` - Error` — validation error state
- ` - Filled` — completed/populated state

Example: `FirstScreenView - Default`, `FirstScreenView - Filled`, `DS.Button / Standard - Disabled`

### File Naming

- Views: `{ScreenName}View.swift`
- ViewModels: `{FlowName}ViewModel.swift`
- Flow coordinators: `{FlowName}Flow.swift`
- Design components: `DS{ComponentName}.swift`
- Design tokens: `DS{Category}.swift`

### Code Style

- Every file starts with a header comment (purpose, flow context)
- Use `// MARK: -` to organize sections
- Include `#Preview` at the bottom of every view file
- Step enums live in the ViewModel file

### Navigation

- Each flow owns its own `NavigationStack(path:)` bound to `viewModel.path`
- Use `.navigationDestination(for: {Step}.self)` for routing
- Always hide system nav bar (`.navigationBarHidden(true)`)
- Pass `onDismiss: () -> Void` closures for flow exit

### State Management

- ViewModels are `@Observable` classes
- Views access ViewModel via `@Environment(ViewModel.self) private var viewModel`
- Views should be as stateless as possible
- Use computed properties for derived state

### SwiftUI Patterns

- Use `VStack(spacing: DSSpacing.none)` as root layout — control spacing explicitly
- Background colors on the outermost container
- Use `Spacer()` for flexible layout, not arbitrary padding
- **ALWAYS** use `DSColors` for colors — never hardcode hex values
- **ALWAYS** use `DSTypography` for fonts — never use `.font(.title)` or `.font(.system(...))`
- **ALWAYS** use `DSSpacing` for padding/spacing — never hardcode numeric values

---

## 7. Asset Management

### 7.1 Icons (DSIcons)

All icons are custom PDF vectors, configured as Template Images (tintable via `foregroundStyle`).

**Icon Sizes** (from Figma spec node `17:122664`):

| Size Constant | Value | Usage |
|---------------|-------|-------|
| `sizeLarge` | 24pt | Navigation icons (back arrow) |
| `sizeMedium` | 20pt | Tab bar / action icons |
| `sizeSmall` | 16pt | Utility icons (close) |
| `sizeXSmall` | 14pt | Indicator icons (error badge) |

**Icon Inventory:**

| Token | Asset Name | Size | Description |
|-------|-----------|------|-------------|
| `arrowLeft` | `arrow_left` | 24px | Back / navigate left |
| `search` | `Search` | 20px | Search action |
| `user` | `User` | 20px | User / profile |
| `shoppingCart` | `Shopping cart` | 20px | Shopping cart |
| `mapPin` | `Map pin` | 20px | Location / map pin |
| `home` | `Home` | 20px | Home tab |
| `close` | `Close icon` | 16px | Close / dismiss |
| `circleExclamation` | `circle_exclamation_point` | 14px | Error / warning indicator |

**Usage:**

```swift
DSIcons.arrowLeft
    .resizable()
    .frame(width: DSIcons.sizeLarge, height: DSIcons.sizeLarge)
    .foregroundStyle(DSColors.contentPrimary)
```

### 7.2 Images (DSImages)

Raster PNG images stored in `Assets.xcassets`, rendered as Original Image.

| Token | Asset Name | Description |
|-------|-----------|-------------|
| `dsImage` | `DS.Image` | Design system placeholder image |
| `homeBG` | `HomeBG` | Home screen background |
| `searchBG` | `SearchBG` | Search screen background |

**Usage:**

```swift
DSImages.homeBG
    .resizable()
    .aspectRatio(contentMode: .fill)
```

### 7.3 Adding New Icons

1. Export from Figma as **PDF** (vector) at 1x
2. Drag into `Assets.xcassets` in Xcode
3. Configure: **Single Scale**, **Template Image**, **Preserve Vector Data**
4. Add a `static let` to `DSIcons` in `DSIcons.swift`
5. Update this spec and `CLAUDE.md`

### 7.4 Adding New Images

1. Export from Figma as **PNG** (raster)
2. Drag into `Assets.xcassets` in Xcode
3. Configure: **Original Image** rendering
4. Add a `static let` to `DSImages` in `DSIcons.swift`
5. Naming convention: `{FlowName}-{description}` (e.g., `OrderCard-confirmation`)

### Adding Components

1. Create in `DesignSystem/Components/` with `DS` prefix
2. Use only token values from `DSColors`, `DSTypography`, `DSSpacing`
3. Include a `#Preview` block at the bottom showing **all states/variants**
4. Add the component to this spec

### Component Testing

Two complementary approaches:

- **`#Preview` blocks** (per-component): Each `DS{Name}.swift` file has a `#Preview` at the bottom showing all states. Use Xcode's canvas for fast iteration — no app launch needed.
- **Component Catalog** (all-at-once): Create a `ComponentCatalogView.swift` in `DesignSystem/` that shows every component in a scrollable view. Run the app to see all components together in a real device context.

---

## 8. How to Add a New Flow

See **FLOW_TEMPLATE.md** for the complete step-by-step checklist with code templates.
