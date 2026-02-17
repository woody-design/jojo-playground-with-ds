//
//  ExampleFlow2View.swift
//  JoJoPlayground
//
//  Example Flow 2: Home/Search view switching via bottom nav.
//  Two scrollable background images crossfade between Home and Search states.
//  Scroll position resets to top on every switch. Only the active
//  background accepts scroll touches.
//  Figma references: nodes 19:5082 (HomeView), 19:5090 (SearchView)
//

import SwiftUI

// MARK: - ExampleFlow2View

struct ExampleFlow2View: View {

    @Environment(ExampleFlow2ViewModel.self) private var viewModel
    var onDismiss: () -> Void

    // MARK: - Scroll State

    private let homeBGAnchor = "homeBGTop"
    private let searchBGAnchor = "searchBGTop"

    // MARK: - Body

    var body: some View {
        ZStack(alignment: .bottom) {

            // MARK: Home Background
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    DSImages.homeBG
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .id(homeBGAnchor)
                }
                .ignoresSafeArea(edges: .top)
                .opacity(viewModel.focus == .home ? 1 : 0)
                .allowsHitTesting(viewModel.focus == .home)
                .animation(.easeInOut(duration: 0.3), value: viewModel.focus)
                .onChange(of: viewModel.focus) { _, newValue in
                    if newValue == .home {
                        proxy.scrollTo(homeBGAnchor, anchor: .top)
                    }
                }
            }

            // MARK: Search Background
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    DSImages.searchBG
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .id(searchBGAnchor)
                }
                .ignoresSafeArea(edges: .top)
                .opacity(viewModel.focus == .search ? 1 : 0)
                .allowsHitTesting(viewModel.focus == .search)
                .animation(.easeInOut(duration: 0.3), value: viewModel.focus)
                .onChange(of: viewModel.focus) { _, newValue in
                    if newValue == .search {
                        proxy.scrollTo(searchBGAnchor, anchor: .top)
                    }
                }
            }

            // MARK: Bottom Navigation
            DSBottomNav(
                focus: viewModel.focus,
                onHomeTap: { viewModel.focus = .home },
                onSearchTap: { viewModel.focus = .search }
            )
        }
        .navigationBarHidden(true)
        .overlay(alignment: .topLeading) {
            // MARK: Close Button
            Button(action: onDismiss) {
                DSIcons.close
                    .resizable()
                    .frame(width: DSIcons.sizeLarge, height: DSIcons.sizeLarge)
                    .foregroundStyle(DSColors.contentPrimary)
                    .padding(DSSpacing.s8)
                    .contentShape(Rectangle())
            }
            .padding(.leading, DSSpacing.s16)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ExampleFlow2View(onDismiss: {})
            .environment(ExampleFlow2ViewModel())
    }
}
