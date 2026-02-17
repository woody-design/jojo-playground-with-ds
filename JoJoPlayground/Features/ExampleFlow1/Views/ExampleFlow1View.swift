//
//  ExampleFlow1View.swift
//  JoJoPlayground
//
//  Example Flow 1: Single screen with two tabs.
//  Tab A: Title (updated by Tab B input) + Image.
//  Tab B: Toggle-controlled CTA, text field with focus animation, Submit button.
//  Figma references: nodes 18:4437 (Tab A), 18:4448 (Tab B)
//

import SwiftUI

// MARK: - ExampleFlow1View

struct ExampleFlow1View: View {

    @Environment(ExampleFlow1ViewModel.self) private var viewModel
    var onDismiss: () -> Void

    // MARK: - Animation Constants

    private let springAnimation: Animation = .spring(response: 0.35, dampingFraction: 0.85)

    // MARK: - Body

    var body: some View {
        @Bindable var vm = viewModel

        VStack(spacing: DSSpacing.none) {

            // MARK: Navigation Header
            DSNavigationHeader(
                onLeftTap: onDismiss
            )

            // MARK: Tabs (hidden during text field focus)
            DSTabs(
                items: [
                    DSTabItem(label: "Tab A"),
                    DSTabItem(label: "Tab B", badgeCount: 77)
                ],
                selectedIndex: $vm.selectedTab
            )
            .frame(height: viewModel.isTextFieldFocused ? 0 : nil)
            .opacity(viewModel.isTextFieldFocused ? 0 : 1)
            .clipped()
            .allowsHitTesting(!viewModel.isTextFieldFocused)

            // MARK: Tab Content
            switch viewModel.selectedTab {
            case 0:
                tabAContent
            default:
                tabBContent
            }

            Spacer(minLength: DSSpacing.none)

            // MARK: Sticky Footer (Tab B only)
            if viewModel.selectedTab == 1 {
                stickyFooter
            }
        }
        .background(DSColors.backgroundPrimary)
        .navigationBarHidden(true)
        .animation(springAnimation, value: viewModel.isTextFieldFocused)
        .onChange(of: viewModel.selectedTab) { _, _ in
            dismissKeyboardIfNeeded()
        }
    }

    // MARK: - Tab A Content

    private var tabAContent: some View {
        ScrollView {
            VStack(spacing: DSSpacing.none) {
                DSTitle(viewModel.titleText)
                DSImage(image: DSImages.dsImage)
            }
        }
    }

    // MARK: - Tab B Content

    @ViewBuilder
    private var tabBContent: some View {
        @Bindable var vm = viewModel

        ScrollView {
            VStack(spacing: DSSpacing.none) {

                // MARK: List Item with Switch (hidden during focus)
                DSListItem(
                    label: "Switch to control CTA",
                    paragraph: "Placeholder description"
                ) {
                    DSSwitch(isOn: $vm.switchIsOn)
                }
                .frame(height: viewModel.isTextFieldFocused ? 0 : nil)
                .opacity(viewModel.isTextFieldFocused ? 0 : 1)
                .clipped()
                .allowsHitTesting(!viewModel.isTextFieldFocused)

                // MARK: Spacer (hidden during focus)
                Spacer()
                    .frame(height: viewModel.isTextFieldFocused ? 0 : DSSpacing.s96)

                // MARK: Text Field
                DSTextField(
                    label: "Input something",
                    placeholder: "Click to input",
                    hint: "",
                    errorMessage: "Text field cannot be empty",
                    text: $vm.textInput,
                    onFocusChange: { focused in
                        withAnimation(springAnimation) {
                            viewModel.isTextFieldFocused = focused
                        }
                    }
                )
            }
        }
        .scrollDismissesKeyboard(.interactively)
    }

    // MARK: - Sticky Footer

    private var stickyFooter: some View {
        VStack(spacing: DSSpacing.none) {
            DSButton(
                label: "Submit",
                action: {
                    dismissKeyboardIfNeeded()
                },
                isDisabled: !viewModel.isSubmitEnabled
            )
            .padding(.horizontal, DSSpacing.s16)
            .padding(.vertical, DSSpacing.s12)
        }
        .background(DSColors.backgroundPrimary)
    }

    // MARK: - Helpers

    private func dismissKeyboardIfNeeded() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ExampleFlow1View(onDismiss: {})
            .environment(ExampleFlow1ViewModel())
    }
}
