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

    var body: some View {
        ScrollView {
            VStack(spacing: DSSpacing.none) {

                // MARK: - Custom Nav Bar

                HStack(spacing: DSSpacing.s8) {
                    Button {
                        dismiss()
                    } label: {
                        DSIcons.arrowLeft
                            .resizable()
                            .frame(width: DSIcons.sizeLarge, height: DSIcons.sizeLarge)
                            .foregroundStyle(DSColors.contentPrimary)
                    }

                    Spacer()
                }
                .padding(.horizontal, DSSpacing.s16)
                .padding(.vertical, DSSpacing.s12)

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
