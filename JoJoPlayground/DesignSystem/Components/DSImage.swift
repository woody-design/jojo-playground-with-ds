//
//  DSImage.swift
//  JoJoPlayground
//
//  Design system component: Full-width image container.
//  Width fills the parent container; height adjusts proportionally
//  based on the image's aspect ratio.
//  Figma reference: node 17:123367
//

import SwiftUI

// MARK: - DSImage

struct DSImage: View {

    let image: Image

    // MARK: - Body

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    VStack(spacing: DSSpacing.s16) {
        DSImage(image: DSImages.dsImage)
    }
}
