//
//  DSTitle.swift
//  JoJoPlayground
//
//  Design system component: Large title header.
//  Supports multi-line wrapping (no truncation).
//  Figma reference: node 33:1829
//

import SwiftUI

// MARK: - DSTitle

struct DSTitle: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(DSTypography.title)
            .lineSpacing(DSTypography.titleLineHeight - 36)
            .foregroundStyle(DSColors.contentPrimary)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, DSSpacing.s16)
            .padding(.vertical, DSSpacing.s12)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: DSSpacing.none) {
        DSTitle("Single Line Title")
        DSTitle("A Much Longer Title That Will Wrap to the Second Row")
    }
}
