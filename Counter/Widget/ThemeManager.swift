//
//  ThemeManager.swift
//  Counter
//
//  Created by Wojciech Szczepanowski on 24/06/2024.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case blue, green, red, orange, pink, purple, yellow, teal, gray
    
    var id: String { self.rawValue }
    
    var color: Color {
        switch self {
        case .blue: return Color.blue
        case .green: return Color.green
        case .red: return Color.red
        case .orange: return Color.orange
        case .pink: return Color.pink
        case .purple: return Color.purple
        case .yellow: return Color.yellow
        case .teal: return Color.teal
        case .gray: return Color.gray
        }
    }
}

class ThemeManager: ObservableObject {
    @Published var selectedTheme: Theme {
        didSet {
            UserDefaults.standard.set(selectedTheme.rawValue, forKey: "selectedTheme")
        }
    }
    
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    init() {
        let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme") ?? Theme.blue.rawValue
        self.selectedTheme = Theme(rawValue: savedTheme) ?? .blue
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
}

