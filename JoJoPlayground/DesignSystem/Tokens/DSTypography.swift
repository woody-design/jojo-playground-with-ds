//
//  DSTypography.swift
//  JoJoPlayground
//
//  Design tokens: Typography from your design system.
//
//  How to set up custom fonts:
//  1. Export font files (TTF or OTF) from your design system
//  2. Drag them into the Fonts/ directory in this project
//  3. Register each font filename in Info.plist under
//     "Fonts provided by application" (the array is already set up)
//  4. Find the PostScript name for each font:
//     - Open the font in Font Book, look at the PostScript Name field
//     - Or run in Terminal: fc-scan --format "%{postscriptname}\n" YourFont.ttf
//  5. Add the PostScript name as a private static let below
//  6. Define your type styles using Font.custom(name, size:)
//
//  Example:
//    private static let headingSemiBold = "YourFont-SemiBold"
//    static let headline = Font.custom(headingSemiBold, size: 24)
//    static let headlineLineHeight: CGFloat = 28
//

import SwiftUI

enum DSTypography {

    // MARK: - Font Family Names (PostScript names from Lexend Deca static fonts)

    private static let lexendDecaLight = "LexendDeca-Light"
    private static let lexendDecaRegular = "LexendDeca-Regular"
    private static let lexendDecaMedium = "LexendDeca-Medium"

    // MARK: - Type Styles

    /// Title: Lexend Deca Medium, 36px, lineHeight 44px
    /// Used for: Screen titles, primary headings
    static let title = Font.custom(lexendDecaMedium, size: 36)
    static let titleLineHeight: CGFloat = 44

    /// Body Emphasized: Lexend Deca Medium, 18px, lineHeight 28px
    /// Used for: Emphasized body text, section titles
    static let bodyEmphasized = Font.custom(lexendDecaMedium, size: 18)
    static let bodyEmphasizedLineHeight: CGFloat = 28

    /// Body Regular: Lexend Deca Regular, 18px, lineHeight 28px
    /// Used for: Body text, descriptions
    static let bodyRegular = Font.custom(lexendDecaRegular, size: 18)
    static let bodyRegularLineHeight: CGFloat = 28

    /// Accent Emphasized: Lexend Deca Medium, 14px, lineHeight 16px
    /// Used for: Emphasized labels, captions
    static let accentEmphasized = Font.custom(lexendDecaMedium, size: 14)
    static let accentEmphasizedLineHeight: CGFloat = 16

    /// Accent Regular: Lexend Deca Regular, 14px, lineHeight 16px
    /// Used for: Secondary labels, captions
    static let accentRegular = Font.custom(lexendDecaRegular, size: 14)
    static let accentRegularLineHeight: CGFloat = 16

    /// Accent Light: Lexend Deca Light, 14px, lineHeight 16px
    /// Used for: Tertiary labels, subtle text
    static let accentLight = Font.custom(lexendDecaLight, size: 14)
    static let accentLightLineHeight: CGFloat = 16

    /// Accent Small: Lexend Deca Regular, 12px, lineHeight 16px
    /// Used for: Fine print, timestamps, badges
    static let accentSmall = Font.custom(lexendDecaRegular, size: 12)
    static let accentSmallLineHeight: CGFloat = 16
}
