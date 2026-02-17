//
//  ExampleFlow2ViewModel.swift
//  JoJoPlayground
//
//  ViewModel for Example Flow 2.
//  Manages which bottom nav tab is focused (Home or Search).
//  Figma references: nodes 19:5082 (HomeView), 19:5090 (SearchView)
//

import SwiftUI

// MARK: - ExampleFlow2ViewModel

@Observable
class ExampleFlow2ViewModel {

    // MARK: - State Properties

    /// Currently focused bottom nav tab
    var focus: DSBottomNavFocus = .home
}
