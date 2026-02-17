//
//  ContentView.swift
//  JoJoPlayground
//
//  Landing page: the app's root screen.
//  Shows the title, a placeholder list item, and navigation buttons.
//  Only the "Components Catalog" button is connected; others are blank.
//  Figma reference: node 22:5873
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @State private var showCatalog = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: DSSpacing.none) {

                    // Top spacer
                    Spacer().frame(height: DSSpacing.s96)

                    // Title
                    DSTitle("👋 JoJoPlayground")

                    // List item
                    DSListItem(label: "title", paragraph: "Placeholder description")

                    // Gap before buttons
                    Spacer().frame(height: DSSpacing.s64)

                    // Buttons
                    VStack(spacing: DSSpacing.none) {
                        // Button 1 — blank
                        buttonRow {
                            DSButton(label: "Example flow 1", action: { })
                        }

                        // Button 2 — blank
                        buttonRow {
                            DSButton(label: "Example flow 2", action: { })
                        }

                        // Button 3 — blank (green)
                        buttonRow {
                            landingButton(
                                label: "Start your flow",
                                backgroundColor: DSColors.backgroundPositive,
                                action: { }
                            )
                        }

                        // Button 4 — navigates to ComponentCatalogView (yellow)
                        buttonRow {
                            landingButton(
                                label: "Components Catalog",
                                backgroundColor: DSColors.backgroundWarning,
                                action: { showCatalog = true }
                            )
                        }
                    }
                }
            }
            .background(DSColors.backgroundPrimary)
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showCatalog) {
                ComponentCatalogView()
            }
        }
    }

    // MARK: - Helpers

    /// Wraps a button with the landing page row padding
    @ViewBuilder
    private func buttonRow<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(.horizontal, DSSpacing.s16)
            .padding(.vertical, DSSpacing.s12)
    }

    /// Custom-colored button matching DSButton visual structure
    private func landingButton(
        label: String,
        backgroundColor: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(label)
                .font(DSTypography.bodyRegular)
                .foregroundStyle(DSColors.contentInversePrimary)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, DSSpacing.s20)
                .padding(.vertical, DSSpacing.s16)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: DSSpacing.s8))
        }
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}
