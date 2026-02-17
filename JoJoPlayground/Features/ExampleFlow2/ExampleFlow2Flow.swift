//
//  ExampleFlow2Flow.swift
//  JoJoPlayground
//
//  Flow coordinator for Example Flow 2.
//  No internal NavigationStack — this flow has no multi-step navigation.
//  Injects the shared ViewModel via environment.
//  Dismissal: iOS swipe-from-left-edge gesture (pushed onto ContentView's stack).
//  Figma references: nodes 19:5082 (HomeView), 19:5090 (SearchView)
//

import SwiftUI

// MARK: - ExampleFlow2Flow

struct ExampleFlow2Flow: View {
    @State private var viewModel = ExampleFlow2ViewModel()
    var onDismiss: () -> Void

    var body: some View {
        ExampleFlow2View(onDismiss: onDismiss)
            .environment(viewModel)
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ExampleFlow2Flow(onDismiss: {})
    }
}
