//
//  ExampleFlow1ViewModel.swift
//  JoJoPlayground
//
//  ViewModel for Example Flow 1.
//  Manages tab selection, toggle state, text input, and focus tracking.
//  Figma references: nodes 18:4437 (Tab A), 18:4448 (Tab B)
//

import SwiftUI

// MARK: - ExampleFlow1ViewModel

@Observable
class ExampleFlow1ViewModel {

    // MARK: - State Properties

    /// Currently selected tab index (0 = Tab A, 1 = Tab B)
    var selectedTab: Int = 0

    /// Toggle state in the DSListItem on Tab B
    var switchIsOn: Bool = true

    /// Text field input value on Tab B
    var textInput: String = ""

    /// Whether the text field is currently focused (keyboard visible)
    var isTextFieldFocused: Bool = false

    // MARK: - Computed Properties

    /// Title displayed on Tab A — user input or default
    var titleText: String {
        textInput.isEmpty ? "Title" : textInput
    }

    /// Submit button is enabled only when toggle is on AND text is non-empty
    var isSubmitEnabled: Bool {
        switchIsOn && !textInput.isEmpty
    }
}
