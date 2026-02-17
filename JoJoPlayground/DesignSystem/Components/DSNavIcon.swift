//
//  DSNavIcon.swift
//  JoJoPlayground
//
//  Design system component: Circular navigation icon.
//  A 40x40 white circle with shadow containing a 20x20 tintable icon.
//  Used inside DSBottomNav for individual nav bar items.
//  Visual-only component — tap handling is done by the parent.
//  Figma reference: node 19:5098
//

import SwiftUI

// MARK: - DSNavIcon

struct DSNavIcon: View {

    let icon: Image
    var isActive: Bool = false

    // MARK: - Body

    var body: some View {
        icon
            .resizable()
            .frame(width: DSIcons.sizeMedium, height: DSIcons.sizeMedium)
            .foregroundStyle(isActive ? DSColors.contentPrimary : DSColors.contentStateDisabled)
            .animation(.easeInOut(duration: 0.2), value: isActive)
            .frame(width: 40, height: 40)
            .background(DSColors.backgroundPrimary)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Preview

#Preview("Active") {
    DSNavIcon(icon: DSIcons.home, isActive: true)
        .padding()
        .background(Color.gray.opacity(0.2))
}

#Preview("Inactive") {
    DSNavIcon(icon: DSIcons.home, isActive: false)
        .padding()
        .background(Color.gray.opacity(0.2))
}
