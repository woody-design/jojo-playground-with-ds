//
//  JoJoPlaygroundApp.swift
//  JoJoPlayground
//
//  Created by Woody Li  on 2/16/26.
//

import SwiftUI

@main
struct JoJoPlaygroundApp: App {

    init() {
        #if DEBUG
        for family in UIFont.familyNames.sorted() {
            for name in UIFont.fontNames(forFamilyName: family) {
                print("Font available: \(family) -- \(name)")
            }
        }
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
