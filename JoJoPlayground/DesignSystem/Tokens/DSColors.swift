//
//  DSColors.swift
//  JoJoPlayground
//
//  Design tokens: Colors from your design system.
//  Add your color tokens here. Each token should have a descriptive name
//  and map to a specific hex value from your Figma design system.
//
//  Example:
//    static let primaryBackground = Color(hex: "#ffffff")
//    static let primaryText = Color(hex: "#1a1a1a")
//

import SwiftUI

// MARK: - Color Hex Extension

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Design System Colors

enum DSColors {

    // MARK: - Primitives

    static let primitiveBlack = Color(hex: "#000000")
    static let primitiveWhite = Color(hex: "#FFFFFF")
    static let primitiveBlue600 = Color(hex: "#276EF1")
    static let primitiveRed600 = Color(hex: "#DE1135")
    static let primitiveYellow300 = Color(hex: "#F6BC2F")
    static let primitiveGreen600 = Color(hex: "#0E8345")

    // MARK: - Background

    static let backgroundPrimary = Color(hex: "#FFFFFF")
    static let backgroundSecondary = Color(hex: "#F3F3F3")
    static let backgroundTertiary = Color(hex: "#E8E8E8")

    // MARK: - Content

    static let contentPrimary = Color(hex: "#000000")
    static let contentSecondary = Color(hex: "#4B4B4B")
    static let contentTertiary = Color(hex: "#5E5E5E")

    // MARK: - Border

    static let borderOpaque = Color(hex: "#E8E8E8")
    static let borderSelected = Color(hex: "#000000")

    // MARK: - Inverse

    static let backgroundInversePrimary = Color(hex: "#000000")
    static let backgroundInverseSecondary = Color(hex: "#282828")

    static let contentInversePrimary = Color(hex: "#FFFFFF")
    static let contentInverseSecondary = Color(hex: "#DDDDDD")
    static let contentInverseTertiary = Color(hex: "#A6A6A6")

    static let borderInverseOpaque = Color(hex: "#4B4B4B")
    static let borderInverseSelected = Color(hex: "#FFFFFF")

    // MARK: - Background Extensions

    static let backgroundStateDisabled = Color(hex: "#F3F3F3")
    static let backgroundAccent = Color(hex: "#276EF1")
    static let backgroundNegative = Color(hex: "#DE1135")
    static let backgroundWarning = Color(hex: "#F6BC2F")
    static let backgroundPositive = Color(hex: "#0E8345")
    static let backgroundAccentLight = Color(hex: "#EFF4FE")
    static let backgroundNegativeLight = Color(hex: "#FFF0EE")
    static let backgroundWarningLight = Color(hex: "#FDF2DC")
    static let backgroundPositiveLight = Color(hex: "#EAF6ED")
    static let backgroundAlwaysDark = Color(hex: "#000000")
    static let backgroundAlwaysLight = Color(hex: "#FFFFFF")

    // MARK: - Content Extensions

    static let contentStateDisabled = Color(hex: "#A6A6A6")
    static let contentOnColor = Color(hex: "#FFFFFF")
    static let contentOnColorInverse = Color(hex: "#000000")
    static let contentAccent = Color(hex: "#276EF1")
    static let contentNegative = Color(hex: "#DE1135")
    static let contentWarning = Color(hex: "#9F6402")
    static let contentPositive = Color(hex: "#0E8345")

    // MARK: - Border Extensions

    static let borderStateDisabled = Color(hex: "#F3F3F3")
    static let borderAccent = Color(hex: "#276EF1")
    static let borderNegative = Color(hex: "#DE1135")
    static let borderWarning = Color(hex: "#9F6402")
    static let borderPositive = Color(hex: "#0E8345")
    static let borderAccentLight = Color(hex: "#CDDEFF")

    // MARK: - Programs

    static let programsSafety = Color(hex: "#276EF1")
    static let programsEats = Color(hex: "#0E8345")
    static let programsFreight = Color(hex: "#0E1FC1")
    static let programsRewardsTier2 = Color(hex: "#FFC043")
    static let programsRewardsTier3 = Color(hex: "#8FA3AD")
    static let programsRewardsTier4 = Color(hex: "#000000")
    static let programsMembership = Color(hex: "#9F6402")
}
