//
//  ComponentCatalogView.swift
//  JoJoPlayground
//
//  Showcases all design system components in all their states.
//  Accessible from the landing page via the "Components Catalog" button.
//

import SwiftUI

// MARK: - ComponentCatalogView

struct ComponentCatalogView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var switchOn1 = false
    @State private var switchOn2 = true
    @State private var textFieldText1 = ""
    @State private var textFieldText2 = ""
    @State private var twoTabSelection = 0
    @State private var threeTabSelection = 0

    var body: some View {
        ScrollView {
            VStack(spacing: DSSpacing.none) {

                // MARK: - Custom Nav Bar

                DSNavigationHeader(
                    title: "Components",
                    onLeftTap: { dismiss() }
                )

                // MARK: - DSTabs Section

                DSTitle("DSTabs")

                VStack(spacing: DSSpacing.s12) {
                    Text("2 tabs — static, equal width")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentTertiary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)

                    DSTabs(
                        items: [
                            DSTabItem(label: "Label 1"),
                            DSTabItem(label: "Label 2", badgeCount: 5)
                        ],
                        selectedIndex: $twoTabSelection
                    )

                    Text("Selected: Tab \(twoTabSelection + 1)")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)
                }

                Spacer().frame(height: DSSpacing.s24)

                VStack(spacing: DSSpacing.s12) {
                    Text("3 tabs — scrollable, text-fit width")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentTertiary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)

                    DSTabs(
                        items: [
                            DSTabItem(label: "This is long"),
                            DSTabItem(label: "This is even longer"),
                            DSTabItem(label: "Who wrote those?")
                        ],
                        selectedIndex: $threeTabSelection
                    )

                    Text("Selected: Tab \(threeTabSelection + 1)")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)
                }

                Spacer().frame(height: DSSpacing.s24)

                VStack(spacing: DSSpacing.s12) {
                    Text("2 tabs — long text truncation")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentTertiary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)

                    DSTabs(
                        items: [
                            DSTabItem(label: "This label is very long and should truncate"),
                            DSTabItem(label: "Another long label text", badgeCount: 99)
                        ],
                        selectedIndex: .constant(0)
                    )
                }

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSBadge Section

                DSTitle("DSBadge")

                HStack(spacing: DSSpacing.s16) {
                    DSBadge(count: 1)
                    DSBadge(count: 9)
                    DSBadge(count: 42)
                    DSBadge(count: 99)
                }
                .padding(.horizontal, DSSpacing.s16)

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSNavigationHeader Section

                DSTitle("DSNavigationHeader")

                VStack(spacing: DSSpacing.s12) {
                    Text("With title + back button")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentTertiary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)

                    DSNavigationHeader(
                        title: "Title",
                        onLeftTap: { }
                    )
                    .background(DSColors.backgroundSecondary)

                    Text("Without title")
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentTertiary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, DSSpacing.s16)

                    DSNavigationHeader(
                        onLeftTap: { }
                    )
                    .background(DSColors.backgroundSecondary)
                }

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSTextField Section

                DSTitle("DSTextField")

                VStack(spacing: DSSpacing.s16) {
                    DSTextField(
                        label: "Label",
                        placeholder: "Placeholder",
                        hint: "Hint",
                        errorMessage: "Text field cannot be empty",
                        text: $textFieldText1
                    )

                    DSTextField(
                        label: "Another Field",
                        placeholder: "Try submitting empty",
                        hint: "Press return with no text to see error",
                        errorMessage: "Text field cannot be empty",
                        text: $textFieldText2
                    )

                    DSButton(
                        label: "CTA (disabled when empty)",
                        action: { },
                        isDisabled: textFieldText1.isEmpty
                    )
                    .padding(.horizontal, DSSpacing.s16)
                }

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSButton Section

                DSTitle("DSButton")

                VStack(spacing: DSSpacing.s12) {
                    DSButton(label: "Default", action: { })
                    DSButton(label: "Disabled", action: { }, isDisabled: true)
                }
                .padding(.horizontal, DSSpacing.s16)

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSTitle Section

                DSTitle("DSTitle")

                VStack(spacing: DSSpacing.s8) {
                    DSTitle("Single Line")
                    DSTitle("A Longer Title That Wraps to Multiple Lines")
                }

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSSwitch Section

                DSTitle("DSSwitch")

                VStack(spacing: DSSpacing.s16) {
                    HStack {
                        Text("Off → toggle me")
                            .font(DSTypography.bodyRegular)
                            .foregroundStyle(DSColors.contentPrimary)
                        Spacer()
                        DSSwitch(isOn: $switchOn1)
                    }
                    HStack {
                        Text("On → toggle me")
                            .font(DSTypography.bodyRegular)
                            .foregroundStyle(DSColors.contentPrimary)
                        Spacer()
                        DSSwitch(isOn: $switchOn2)
                    }
                }
                .padding(.horizontal, DSSpacing.s16)

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSListItem Section

                DSTitle("DSListItem")

                DSListItem(label: "With Switch", paragraph: "Tap the switch to toggle") {
                    DSSwitch(isOn: $switchOn1)
                }

                DSListItem(label: "Without Control", paragraph: "Plain two-line list item")

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSImage Section

                DSTitle("DSImage")

                DSImage(image: DSImages.dsImage)

                Spacer().frame(height: DSSpacing.s48)

                // MARK: - DSBGHardcoded Section

                DSTitle("DSBGHardcoded")

                Text("Scrollable background — shown in constrained frame")
                    .font(DSTypography.accentRegular)
                    .foregroundStyle(DSColors.contentTertiary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, DSSpacing.s16)

                ZStack {
                    DSBGHardcoded(image: DSImages.homeBG)
                }
                .frame(height: 200)
                .clipped()

                Spacer().frame(height: DSSpacing.s64)
            }
        }
        .background(DSColors.backgroundPrimary)
        .navigationBarHidden(true)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ComponentCatalogView()
    }
}
