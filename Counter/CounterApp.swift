//
//  CounterApp.swift
//  Counter
//
//  Created by Wojciech Szczepanowski on 19/06/2024.
//

import SwiftUI

@main
struct CounterApp: App {
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
        }
    }
}
