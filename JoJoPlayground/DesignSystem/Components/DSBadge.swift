//
//  DSBadge.swift
//  JoJoPlayground
//
//  Design system component: Notification count badge.
//  Displays a number inside a small black circle.
//  Used standalone or nested inside DSTabs.
//  Supports an optional count-up animation triggered externally.
//  Figma reference: node 17:123672
//

import SwiftUI

// MARK: - DSBadge

struct DSBadge: View {

    let count: Int
    var countUpTrigger: Int = 0

    // MARK: - Layout Constants

    private let badgeSize: CGFloat = 20

    // MARK: - Animation Constants

    private let animationDuration: Double = 0.8
    private let maxSteps: Int = 20

    // MARK: - Internal State

    @State private var displayedCount: Int = 0
    @State private var hasAppeared = false

    // MARK: - Body

    var body: some View {
        Text("\(displayedCount)")
            .font(DSTypography.accentSmall)
            .lineSpacing(DSTypography.accentSmallLineHeight - 12)
            .foregroundStyle(DSColors.contentInversePrimary)
            .frame(width: badgeSize, height: badgeSize)
            .background(DSColors.backgroundInversePrimary)
            .clipShape(Circle())
            .accessibilityLabel("\(count) notifications")
            .onAppear {
                displayedCount = count
                hasAppeared = true
            }
            .task(id: countUpTrigger) {
                guard hasAppeared, countUpTrigger > 0 else {
                    displayedCount = count
                    return
                }
                await runCountUp()
            }
    }

    // MARK: - Count-Up Animation

    private func runCountUp() async {
        guard count > 0 else {
            displayedCount = count
            return
        }

        displayedCount = 0
        let steps = min(count, maxSteps)
        let interval = animationDuration / Double(steps)

        for step in 1...steps {
            try? await Task.sleep(for: .seconds(interval))
            let progress = easeOut(Double(step) / Double(steps))
            displayedCount = max(1, Int(round(Double(count) * progress)))
        }

        displayedCount = count
    }

    private func easeOut(_ t: Double) -> Double {
        1 - pow(1 - t, 3)
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: DSSpacing.s16) {
        DSBadge(count: 1)
        DSBadge(count: 9)
        DSBadge(count: 99)
    }
}
