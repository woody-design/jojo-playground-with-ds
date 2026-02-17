//
//  DSBGHardcoded.swift
//  JoJoPlayground
//
//  Design system component: Full-screen scrollable background image
//  for prototyping. Always placed at the back of a ZStack. Width fills
//  the device; height depends on the image and scrolls vertically.
//  Figma reference: node 17:124020
//
//  Usage:
//    ZStack {
//        DSBGHardcoded(image: DSImages.homeBG)
//        VStack { /* overlay content */ }
//    }
//

import SwiftUI

// MARK: - DSBGHardcoded

struct DSBGHardcoded: View {

    let image: Image

    // MARK: - Body

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

// MARK: - Preview

#Preview("HomeBG") {
    ZStack {
        DSBGHardcoded(image: DSImages.homeBG)
    }
}

#Preview("SearchBG") {
    ZStack {
        DSBGHardcoded(image: DSImages.searchBG)
    }
}
