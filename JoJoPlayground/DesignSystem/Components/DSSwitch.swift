//
//  DSSwitch.swift
//  JoJoPlayground
//
//  Design system component: Toggle switch with On/Off states.
//  Includes spring animation, thumb stretch effect, track color
//  crossfade, and haptic feedback.
//  Figma reference: node 33:1830
//

import SwiftUI

// MARK: - DSSwitch

struct DSSwitch: View {

    @Binding var isOn: Bool

    // MARK: - Layout Constants

    private let trackWidth: CGFloat = 52
    private let trackHeight: CGFloat = 32
    private let thumbSize: CGFloat = 28
    private let thumbStretchWidth: CGFloat = 34
    private let trackPadding: CGFloat = 2

    // MARK: - Internal State

    @State private var isAnimating = false

    // MARK: - Computed Properties

    private var thumbOffset: CGFloat {
        let travel = trackWidth - thumbSize - (trackPadding * 2)
        return isOn ? travel / 2 : -travel / 2
    }

    private var currentThumbWidth: CGFloat {
        isAnimating ? thumbStretchWidth : thumbSize
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            // Track
            Capsule()
                .fill(isOn ? DSColors.backgroundInversePrimary : DSColors.backgroundTertiary)
                .frame(width: trackWidth, height: trackHeight)

            // Thumb
            Capsule()
                .fill(DSColors.contentInversePrimary)
                .frame(width: currentThumbWidth, height: thumbSize)
                .offset(x: thumbOffset)
        }
        .frame(width: trackWidth, height: trackHeight)
        .onTapGesture {
            toggle()
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Toggle")
        .accessibilityValue(isOn ? "On" : "Off")
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Actions

    private func toggle() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        // Start stretch
        withAnimation(.easeOut(duration: 0.1)) {
            isAnimating = true
        }

        // Toggle state + slide with spring
        withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
            isOn.toggle()
        }

        // End stretch after the slide begins
        withAnimation(.spring(response: 0.35, dampingFraction: 0.7).delay(0.1)) {
            isAnimating = false
        }
    }
}

// MARK: - Preview

#Preview {
    struct SwitchPreview: View {
        @State private var isOn1 = false
        @State private var isOn2 = true

        var body: some View {
            VStack(spacing: DSSpacing.s24) {
                HStack {
                    Text("Off")
                        .font(DSTypography.bodyRegular)
                    DSSwitch(isOn: $isOn1)
                }
                HStack {
                    Text("On")
                        .font(DSTypography.bodyRegular)
                    DSSwitch(isOn: $isOn2)
                }
            }
        }
    }

    return SwitchPreview()
}
