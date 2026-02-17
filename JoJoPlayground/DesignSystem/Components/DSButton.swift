//
//  DSButton.swift
//  JoJoPlayground
//
//  Design system component: Primary action button.
//  States: Default, Pressed (white overlay), Disabled (gray).
//  Figma reference: node 33:1816
//

import SwiftUI

// MARK: - DSButton

struct DSButton: View {
    let label: String
    let action: () -> Void
    var isDisabled: Bool = false

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(DSTypography.bodyRegular)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, DSSpacing.s20)
                .padding(.vertical, DSSpacing.s16)
        }
        .buttonStyle(DSButtonStyle(isDisabled: isDisabled))
        .disabled(isDisabled)
    }
}

// MARK: - DSButtonStyle

private struct DSButtonStyle: ButtonStyle {
    let isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(
                isDisabled
                    ? DSColors.contentStateDisabled
                    : DSColors.contentInversePrimary
            )
            .background(
                isDisabled
                    ? DSColors.backgroundStateDisabled
                    : DSColors.backgroundInversePrimary
            )
            .clipShape(RoundedRectangle(cornerRadius: DSSpacing.s8))
            .overlay(
                RoundedRectangle(cornerRadius: DSSpacing.s8)
                    .fill(Color.white.opacity(0.2))
                    .opacity(configuration.isPressed && !isDisabled ? 1 : 0)
            )
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: DSSpacing.s16) {
        DSButton(label: "Default Button", action: { })
        DSButton(label: "Disabled Button", action: { }, isDisabled: true)
    }
    .padding(.horizontal, DSSpacing.s16)
}
