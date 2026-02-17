//
//  ExampleFlow1Flow.swift
//  JoJoPlayground
//
//  Flow coordinator for Example Flow 1.
//  Wraps the single-screen tab view in a NavigationStack
//  and injects the shared ViewModel via environment.
//  Figma references: nodes 18:4437 (Tab A), 18:4448 (Tab B)
//

import SwiftUI

// MARK: - ExampleFlow1Flow

struct ExampleFlow1Flow: View {
    @State private var viewModel = ExampleFlow1ViewModel()
    var onDismiss: () -> Void

    var body: some View {
        NavigationStack {
            ExampleFlow1View(onDismiss: onDismiss)
        }
        .environment(viewModel)
    }
}

// MARK: - Preview

#Preview {
    ExampleFlow1Flow(onDismiss: {})
}
