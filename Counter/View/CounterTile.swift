//
//  CounterTile.swift
//  Counter
//
//  Created by Wojciech Szczepanowski on 19/06/2024.
//

import SwiftUI

struct CounterTile: View {
    @ObservedObject var cigarettesCount: Cigarettes_Count
    var themeColor: Color

    var body: some View {
        GeometryReader { geometry in
            Text("\(cigarettesCount.countedCigarettes)")
                .font(.system(size: min(geometry.size.width, geometry.size.height) * 0.3))
                .foregroundColor(themeColor)
                .frame(width: geometry.size.width - 20, height: geometry.size.height - 20)
                .background(themeColor.opacity(0.3)) // Use theme color with 30% opacity
                .cornerRadius(20)
                .padding(10)
                .shadow(radius: 10)
        }
    }
}

struct CounterTile_Previews: PreviewProvider {
    static var previews: some View {
        CounterTile(cigarettesCount: Cigarettes_Count(), themeColor: .blue)
            .frame(height: 500)
    }
}

