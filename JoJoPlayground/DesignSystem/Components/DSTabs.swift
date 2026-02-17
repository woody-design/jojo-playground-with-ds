//
//  DSTabs.swift
//  JoJoPlayground
//
//  Design system component: Segmented tab bar with single selection.
//  Two layout modes determined by tab count:
//    - 2 tabs: Static equal-width layout, text truncates, not scrollable
//    - 3+ tabs: Scrollable layout, text-fit width, no truncation
//  Supports optional DSBadge per tab.
//  Includes sliding highlight bar animation and haptic feedback.
//  Figma references: nodes 17:123966, 17:123785, 17:123946
//

import SwiftUI

// MARK: - DSTabItem

struct DSTabItem {
    let label: String
    let badgeCount: Int?

    init(label: String, badgeCount: Int? = nil) {
        self.label = label
        self.badgeCount = badgeCount
    }
}

// MARK: - DSTabs

struct DSTabs: View {

    let items: [DSTabItem]
    @Binding var selectedIndex: Int

    // MARK: - Layout Constants

    private let tabHeight: CGFloat = DSSpacing.s56
    private let highlightHeight: CGFloat = DSSpacing.s4
    private let contentPadding: CGFloat = DSSpacing.s16
    private let badgeGap: CGFloat = DSSpacing.s8

    // MARK: - Animation

    @Namespace private var highlightNamespace
    @State private var badgeAnimationTrigger: Int = 0

    // MARK: - Validated Selection

    private var safeIndex: Int {
        min(max(selectedIndex, 0), items.count - 1)
    }

    // MARK: - Body

    var body: some View {
        let _ = precondition(items.count >= 2, "DSTabs requires at least 2 items")

        if items.count == 2 {
            staticLayout
        } else {
            scrollableLayout
        }
    }

    // MARK: - Static Layout (2 Tabs)

    private var staticLayout: some View {
        GeometryReader { geometry in
            let tabWidth = geometry.size.width / 2

            HStack(spacing: DSSpacing.none) {
                ForEach(0..<items.count, id: \.self) { index in
                    staticTab(item: items[index], index: index, width: tabWidth)
                }
            }
        }
        .frame(height: tabHeight)
    }

    private func staticTab(item: DSTabItem, index: Int, width: CGFloat) -> some View {
        let isSelected = index == safeIndex

        return Button {
            selectTab(index)
        } label: {
            VStack(spacing: DSSpacing.none) {
                HStack(spacing: badgeGap) {
                    Text(item.label)
                        .font(DSTypography.accentEmphasized)
                        .lineSpacing(DSTypography.accentEmphasizedLineHeight - 14)
                        .foregroundStyle(DSColors.contentPrimary)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    if let count = item.badgeCount {
                        DSBadge(
                            count: count,
                            countUpTrigger: isSelected ? badgeAnimationTrigger : 0
                        )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()

                highlightBar(isSelected: isSelected)
            }
        }
        .buttonStyle(.plain)
        .frame(width: width, height: tabHeight)
        .background(DSColors.backgroundPrimary)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(tabAccessibilityLabel(item: item, isSelected: isSelected))
    }

    // MARK: - Scrollable Layout (3+ Tabs)

    private var scrollableLayout: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DSSpacing.none) {
                    ForEach(0..<items.count, id: \.self) { index in
                        scrollableTab(item: items[index], index: index)
                    }
                }
            }
            .onChange(of: selectedIndex) { _, newValue in
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    proxy.scrollTo(newValue, anchor: .center)
                }
            }
        }
        .frame(height: tabHeight)
    }

    private func scrollableTab(item: DSTabItem, index: Int) -> some View {
        let isSelected = index == safeIndex

        return Button {
            selectTab(index)
        } label: {
            VStack(spacing: DSSpacing.none) {
                HStack(spacing: badgeGap) {
                    Text(item.label)
                        .font(DSTypography.accentEmphasized)
                        .lineSpacing(DSTypography.accentEmphasizedLineHeight - 14)
                        .foregroundStyle(DSColors.contentPrimary)
                        .fixedSize(horizontal: true, vertical: false)

                    if let count = item.badgeCount {
                        DSBadge(
                            count: count,
                            countUpTrigger: isSelected ? badgeAnimationTrigger : 0
                        )
                    }
                }
                .padding(.horizontal, contentPadding)
                .frame(maxHeight: .infinity)

                highlightBar(isSelected: isSelected)
            }
        }
        .buttonStyle(.plain)
        .frame(height: tabHeight)
        .background(DSColors.backgroundPrimary)
        .id(index)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(tabAccessibilityLabel(item: item, isSelected: isSelected))
    }

    // MARK: - Highlight Bar

    @ViewBuilder
    private func highlightBar(isSelected: Bool) -> some View {
        if isSelected {
            Rectangle()
                .fill(DSColors.borderSelected)
                .frame(height: highlightHeight)
                .matchedGeometryEffect(id: "highlight", in: highlightNamespace)
        } else {
            Rectangle()
                .fill(DSColors.borderOpaque)
                .frame(height: highlightHeight)
        }
    }

    // MARK: - Actions

    private func selectTab(_ index: Int) {
        guard index != selectedIndex else { return }

        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        if items[index].badgeCount != nil {
            badgeAnimationTrigger += 1
        }

        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            selectedIndex = index
        }
    }

    // MARK: - Accessibility

    private func tabAccessibilityLabel(item: DSTabItem, isSelected: Bool) -> String {
        var label = item.label
        if let count = item.badgeCount {
            label += ", \(count) notifications"
        }
        if isSelected {
            label += ", selected"
        }
        return label
    }
}

// MARK: - Preview

#Preview("2 Tabs") {
    struct TwoTabPreview: View {
        @State private var selected = 0

        var body: some View {
            VStack(spacing: DSSpacing.none) {
                DSTabs(
                    items: [
                        DSTabItem(label: "Label 1"),
                        DSTabItem(label: "Label 2", badgeCount: 5)
                    ],
                    selectedIndex: $selected
                )

                Text("Selected: Tab \(selected + 1)")
                    .font(DSTypography.bodyRegular)
                    .foregroundStyle(DSColors.contentPrimary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(DSColors.backgroundPrimary)
        }
    }

    return TwoTabPreview()
}

#Preview("2 Tabs - Long Text") {
    struct TwoTabLongPreview: View {
        @State private var selected = 0

        var body: some View {
            DSTabs(
                items: [
                    DSTabItem(label: "This is a very long label that should truncate"),
                    DSTabItem(label: "Another extremely long label text here", badgeCount: 99)
                ],
                selectedIndex: $selected
            )
            .background(DSColors.backgroundPrimary)
        }
    }

    return TwoTabLongPreview()
}

#Preview("3 Tabs - Scrollable") {
    struct ThreeTabPreview: View {
        @State private var selected = 0

        var body: some View {
            VStack(spacing: DSSpacing.none) {
                DSTabs(
                    items: [
                        DSTabItem(label: "This is long"),
                        DSTabItem(label: "This is even longer"),
                        DSTabItem(label: "Who wrote those?")
                    ],
                    selectedIndex: $selected
                )

                Text("Selected: Tab \(selected + 1)")
                    .font(DSTypography.bodyRegular)
                    .foregroundStyle(DSColors.contentPrimary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(DSColors.backgroundPrimary)
        }
    }

    return ThreeTabPreview()
}

#Preview("5 Tabs - Many") {
    struct ManyTabPreview: View {
        @State private var selected = 0

        var body: some View {
            DSTabs(
                items: [
                    DSTabItem(label: "Home"),
                    DSTabItem(label: "Search", badgeCount: 3),
                    DSTabItem(label: "Notifications", badgeCount: 12),
                    DSTabItem(label: "Messages"),
                    DSTabItem(label: "Profile")
                ],
                selectedIndex: $selected
            )
            .background(DSColors.backgroundPrimary)
        }
    }

    return ManyTabPreview()
}
