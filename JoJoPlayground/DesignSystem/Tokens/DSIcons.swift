//
//  DSIcons.swift
//  JoJoPlayground
//
//  Design tokens: Icon references and sizes from your design system.
//  All custom icons are stored in Assets.xcassets as PDF vectors
//  with Template Image rendering (tintable via foregroundStyle).
//
//  Icon sizes come from the Figma Icon spec (node 17:122664):
//    24px — navigation (back arrow)
//    20px — tab bar / action icons
//    16px — utility (close)
//    14px — indicators (error badge)
//

import SwiftUI

enum DSIcons {

    // MARK: - Icon Sizes

    /// 24pt — navigation icons (back arrow)
    static let sizeLarge: CGFloat = 24

    /// 20pt — tab bar and action icons
    static let sizeMedium: CGFloat = 20

    /// 16pt — utility icons (close)
    static let sizeSmall: CGFloat = 16

    /// 14pt — indicator icons (error badge)
    static let sizeXSmall: CGFloat = 14

    // MARK: - 24px Icons

    /// Back arrow — 24x24
    static let arrowLeft = Image("arrow_left")

    // MARK: - 20px Icons

    /// Search — 20x20
    static let search = Image("Search")

    /// User / profile — 20x20
    static let user = Image("User")

    /// Shopping cart — 20x20
    static let shoppingCart = Image("Shopping cart")

    /// Map pin / location — 20x20
    static let mapPin = Image("Map pin")

    /// Home — 20x20
    static let home = Image("Home")

    // MARK: - 16px Icons

    /// Close / dismiss — 16x16
    static let close = Image("Close icon")

    // MARK: - 14px Icons

    /// Error / warning indicator — 14x14
    static let circleExclamation = Image("circle_exclamation_point")
}

// MARK: - DSImages

enum DSImages {

    /// Placeholder image component from design system
    static let dsImage = Image("DS.Image")

    /// Home screen background
    static let homeBG = Image("HomeBG")

    /// Search screen background
    static let searchBG = Image("SearchBG")
}
