//
//  DSTextField.swift
//  JoJoPlayground
//
//  Design system component: Text input with label, placeholder, and hint.
//  States: Default (gray fill), Active (black border, clear button),
//          Error (red border, error message).
//  Figma reference: node 17:123037
//

import SwiftUI

// MARK: - DSTextField

struct DSTextField: View {

    let label: String
    let placeholder: String
    let hint: String
    let errorMessage: String
    @Binding var text: String
    var onFocusChange: ((Bool) -> Void)? = nil

    // MARK: - Internal State

    @FocusState private var isFocused: Bool
    @State private var showError: Bool = false

    // MARK: - Layout Constants

    private let fieldHeight: CGFloat = 36
    private let borderWidth: CGFloat = 3

    // MARK: - Computed State

    private var isError: Bool { showError && text.isEmpty }
    private var isActive: Bool { isFocused && !isError }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: DSSpacing.s8) {

            // MARK: Label
            Text(label)
                .font(isActive || isError ? DSTypography.accentEmphasized : DSTypography.accentRegular)
                .foregroundStyle(DSColors.contentPrimary)

            // MARK: Text Field Box
            HStack(spacing: DSSpacing.none) {
                ZStack(alignment: .leading) {
                    // Custom placeholder overlay
                    if text.isEmpty {
                        Text(placeholder)
                            .font(isFocused ? DSTypography.accentRegular : DSTypography.accentLight)
                            .foregroundStyle(DSColors.contentTertiary)
                            .padding(.horizontal, DSSpacing.s8)
                            .allowsHitTesting(false)
                    }

                    // Native TextField
                    TextField("", text: $text)
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentPrimary)
                        .textFieldStyle(.plain)
                        .padding(.horizontal, DSSpacing.s8)
                        .focused($isFocused)
                        .onSubmit {
                            if text.isEmpty {
                                showError = true
                            }
                        }
                        .onChange(of: text) {
                            if !text.isEmpty {
                                showError = false
                            }
                        }
                }

                // Clear button (Active only)
                if isActive {
                    Button {
                        text = ""
                    } label: {
                        DSIcons.close
                            .resizable()
                            .frame(width: DSIcons.sizeSmall, height: DSIcons.sizeSmall)
                            .foregroundStyle(DSColors.contentPrimary)
                    }
                    .padding(.horizontal, DSSpacing.s8)
                }
            }
            .frame(height: fieldHeight)
            .background(
                isActive || isError
                    ? DSColors.backgroundPrimary
                    : DSColors.backgroundTertiary
            )
            .clipShape(RoundedRectangle(cornerRadius: DSSpacing.s8))
            .overlay(
                RoundedRectangle(cornerRadius: DSSpacing.s8)
                    .stroke(
                        isError
                            ? DSColors.borderNegative
                            : isActive
                                ? DSColors.borderSelected
                                : Color.clear,
                        lineWidth: isActive || isError ? borderWidth : 0
                    )
            )

            // MARK: Hint / Error
            if isError {
                HStack(alignment: .top, spacing: DSSpacing.s4) {
                    DSIcons.circleExclamation
                        .resizable()
                        .frame(width: DSIcons.sizeXSmall, height: DSIcons.sizeXSmall)
                        .foregroundStyle(DSColors.contentNegative)
                        .padding(.top, 3)

                    Text(errorMessage)
                        .font(DSTypography.accentRegular)
                        .foregroundStyle(DSColors.contentNegative)
                }
            } else {
                Text(hint)
                    .font(DSTypography.accentRegular)
                    .foregroundStyle(DSColors.contentTertiary)
            }
        }
        .padding(.horizontal, DSSpacing.s16)
        .onChange(of: isFocused) { _, newValue in
            onFocusChange?(newValue)
        }
    }
}

// MARK: - Preview

#Preview {
    struct TextFieldPreview: View {
        @State private var text1 = ""
        @State private var text2 = ""
        @State private var text3 = ""

        var body: some View {
            VStack(spacing: DSSpacing.s32) {
                DSTextField(
                    label: "Label",
                    placeholder: "Placeholder",
                    hint: "Hint",
                    errorMessage: "Text field cannot be empty",
                    text: $text1
                )

                DSTextField(
                    label: "Label",
                    placeholder: "Placeholder",
                    hint: "Hint",
                    errorMessage: "Text field cannot be empty",
                    text: $text2
                )

                DSTextField(
                    label: "Label",
                    placeholder: "Placeholder",
                    hint: "Hint",
                    errorMessage: "Text field cannot be empty",
                    text: $text3
                )
            }
            .background(DSColors.backgroundPrimary)
        }
    }

    return TextFieldPreview()
}
