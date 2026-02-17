//
//  DSNavigationHeader.swift
//  JoJoPlayground
//
//  Design system component: Configurable navigation bar.
//  Supports optional centered title and configurable left icon button.
//  Figma reference: node 17:123158
//

import SwiftUI

// MARK: - DSNavigationHeader

struct DSNavigationHeader: View {

    var title: String? = nil
    var leftIcon: Image = DSIcons.arrowLeft
    var onLeftTap: (() -> Void)? = nil

    // MARK: - Layout Constants

    private let headerHeight: CGFloat = 44
    private let iconPadding: CGFloat = 14

    // MARK: - Body

    var body: some View {
        ZStack {
            // Title layer (centered)
            if let title {
                Text(title)
                    .font(DSTypography.bodyRegular)
                    .foregroundStyle(DSColors.contentPrimary)
            }

            // Left button layer (leading-aligned)
            HStack(spacing: DSSpacing.s8) {
                if let onLeftTap {
                    Button(action: onLeftTap) {
                        leftIcon
                            .resizable()
                            .frame(
                                width: DSIcons.sizeMedium,
                                height: DSIcons.sizeMedium
                            )
                            .foregroundStyle(DSColors.contentPrimary)
                            .padding(iconPadding)
                    }
                }

                Spacer()
            }
        }
        .frame(height: headerHeight)
        .padding(.horizontal, DSSpacing.s8)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: DSSpacing.s24) {
        // With title and back button
        DSNavigationHeader(
            title: "Title",
            onLeftTap: { }
        )

        Divider()

        // Without title, with back button
        DSNavigationHeader(
            onLeftTap: { }
        )

        Divider()

        // With title, no left button
        DSNavigationHeader(
            title: "Title Only"
        )
    }
}
