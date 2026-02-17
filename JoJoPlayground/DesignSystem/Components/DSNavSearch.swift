//
//  DSNavSearch.swift
//  JoJoPlayground
//
//  Design system component: Morphing search navigation item.
//  Inactive state: 140x40 white pill with search icon + "Search" label.
//  Active state: 40x40 white circle with search icon only.
//  Two-phase dissolve+morph animation managed via internal @State:
//    Collapsing — text dissolves (0.15s ease), then shape morphs (spring + 0.12s delay)
//    Expanding — shape morphs (spring), then text fades in (0.15s ease after 0.25s)
//  Figma reference: node 19:5105
//

import SwiftUI

// MARK: - DSNavSearch

struct DSNavSearch: View {

    let isActive: Bool

    // MARK: - Internal Animation State

    @State private var showText: Bool
    @State private var isCollapsed: Bool

    // MARK: - Constants

    private let pillWidth: CGFloat = 140
    private let circleSize: CGFloat = 40
    private let springAnimation: Animation = .spring(response: 0.4, dampingFraction: 0.8)

    // MARK: - Init

    init(isActive: Bool) {
        self.isActive = isActive
        self._showText = State(initialValue: !isActive)
        self._isCollapsed = State(initialValue: isActive)
    }

    // MARK: - Body

    var body: some View {
        HStack(spacing: DSSpacing.s8) {
            DSIcons.search
                .resizable()
                .frame(width: DSIcons.sizeMedium, height: DSIcons.sizeMedium)
                .foregroundStyle(isCollapsed ? DSColors.contentPrimary : DSColors.contentStateDisabled)

            if !isCollapsed {
                Text("Search")
                    .font(DSTypography.bodyRegular)
                    .foregroundStyle(DSColors.contentStateDisabled)
                    .lineLimit(1)
                    .opacity(showText ? 1 : 0)
            }
        }
        .frame(width: isCollapsed ? circleSize : pillWidth, height: circleSize)
        .background(DSColors.backgroundPrimary)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
        .onChange(of: isActive) { _, newValue in
            if newValue {
                // Collapsing: dissolve text first, then morph shape
                withAnimation(.easeOut(duration: 0.15)) {
                    showText = false
                }
                withAnimation(springAnimation.delay(0.12)) {
                    isCollapsed = true
                }
            } else {
                // Expanding: morph shape first, then fade text in
                withAnimation(springAnimation) {
                    isCollapsed = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    withAnimation(.easeIn(duration: 0.15)) {
                        showText = true
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview("Active") {
    DSNavSearch(isActive: true)
        .padding()
        .background(Color.gray.opacity(0.2))
}

#Preview("Inactive") {
    DSNavSearch(isActive: false)
        .padding()
        .background(Color.gray.opacity(0.2))
}

#Preview("Interactive") {
    struct PreviewWrapper: View {
        @State var isActive = false
        var body: some View {
            VStack(spacing: DSSpacing.s20) {
                DSNavSearch(isActive: isActive)
                Button("Toggle") { isActive.toggle() }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
        }
    }
    return PreviewWrapper()
}
