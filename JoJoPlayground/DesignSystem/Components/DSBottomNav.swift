//
//  DSBottomNav.swift
//  JoJoPlayground
//
//  Design system component: Bottom navigation bar with 5 items.
//  Contains DSNavIcon instances and one DSNavSearch. Center-aligned
//  HStack with 12pt gap over a gradient background (transparent → white).
//  Only Home and Search are tappable; Pin, Cart, User are decorative.
//  Animation: DSNavSearch manages its own two-phase dissolve+morph;
//  the HStack reflows naturally via the same spring transaction.
//  Figma reference: node 19:5112
//

import SwiftUI

// MARK: - DSBottomNavFocus

enum DSBottomNavFocus {
    case home
    case search
}

// MARK: - DSBottomNav

struct DSBottomNav: View {

    let focus: DSBottomNavFocus
    let onHomeTap: () -> Void
    let onSearchTap: () -> Void

    // MARK: - Body

    var body: some View {
        HStack(spacing: DSSpacing.s12) {

            // MARK: Home — tappable
            Button(action: onHomeTap) {
                DSNavIcon(icon: DSIcons.home, isActive: focus == .home)
            }
            .buttonStyle(.plain)

            // MARK: Map Pin — decorative
            DSNavIcon(icon: DSIcons.mapPin)

            // MARK: Search — tappable
            Button(action: onSearchTap) {
                DSNavSearch(isActive: focus == .search)
            }
            .buttonStyle(.plain)

            // MARK: Shopping Cart — decorative
            DSNavIcon(icon: DSIcons.shoppingCart)

            // MARK: User — decorative
            DSNavIcon(icon: DSIcons.user)
        }
        .frame(height: 80)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                stops: [
                    .init(color: .white.opacity(0), location: 0),
                    .init(color: .white, location: 0.327)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// MARK: - Preview

#Preview("Focus: Home") {
    VStack {
        Spacer()
        DSBottomNav(focus: .home, onHomeTap: {}, onSearchTap: {})
    }
    .background(Color.gray.opacity(0.3))
}

#Preview("Focus: Search") {
    VStack {
        Spacer()
        DSBottomNav(focus: .search, onHomeTap: {}, onSearchTap: {})
    }
    .background(Color.gray.opacity(0.3))
}

#Preview("Interactive") {
    struct PreviewWrapper: View {
        @State var focus: DSBottomNavFocus = .home
        var body: some View {
            VStack {
                Spacer()
                DSBottomNav(
                    focus: focus,
                    onHomeTap: { focus = .home },
                    onSearchTap: { focus = .search }
                )
            }
            .background(Color.gray.opacity(0.3))
        }
    }
    return PreviewWrapper()
}
