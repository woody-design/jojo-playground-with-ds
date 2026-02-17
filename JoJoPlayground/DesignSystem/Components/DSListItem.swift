//
//  DSListItem.swift
//  JoJoPlayground
//
//  Design system component: Two-line list item with optional right control.
//  Shows a label, paragraph, optional trailing control, and a bottom divider.
//  Figma reference: node 33:1842
//

import SwiftUI

// MARK: - DSListItem

struct DSListItem<Control: View>: View {
    let label: String
    let paragraph: String
    let control: Control?

    /// List item with a right-side control (e.g. DSSwitch)
    init(
        label: String,
        paragraph: String,
        @ViewBuilder control: () -> Control
    ) {
        self.label = label
        self.paragraph = paragraph
        self.control = control()
    }

    var body: some View {
        VStack(spacing: DSSpacing.none) {
            // Content row
            HStack(spacing: DSSpacing.none) {
                // Text frame
                VStack(alignment: .leading, spacing: DSSpacing.s4) {
                    Text(label)
                        .font(DSTypography.bodyRegular)
                        .foregroundStyle(DSColors.contentPrimary)

                    Text(paragraph)
                        .font(DSTypography.accentLight)
                        .foregroundStyle(DSColors.contentSecondary)
                }
                .padding(.leading, DSSpacing.s16)
                .padding(.vertical, DSSpacing.s16)

                Spacer(minLength: DSSpacing.none)

                // Control frame (optional)
                if let control {
                    control
                        .padding(.horizontal, DSSpacing.s16)
                        .padding(.vertical, DSSpacing.s8)
                }
            }

            // Divider
            Rectangle()
                .fill(DSColors.borderOpaque)
                .frame(height: 1)
                .padding(.leading, DSSpacing.s16)
        }
        .background(DSColors.backgroundPrimary)
    }
}

// MARK: - Convenience init (no control)

extension DSListItem where Control == EmptyView {
    /// List item without a right-side control
    init(label: String, paragraph: String) {
        self.label = label
        self.paragraph = paragraph
        self.control = nil
    }
}

// MARK: - Preview

#Preview {
    struct ListItemPreview: View {
        @State private var isOn = true

        var body: some View {
            VStack(spacing: DSSpacing.none) {
                DSListItem(label: "With Switch", paragraph: "Toggle this setting") {
                    DSSwitch(isOn: $isOn)
                }
                DSListItem(label: "Without Control", paragraph: "Plain list item")
            }
        }
    }

    return ListItemPreview()
}
