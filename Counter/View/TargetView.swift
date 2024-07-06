//
//  TargetView.swift
//  Counter
//
//  Created by Wojciech Szczepanowski on 29/06/2024.
//

import SwiftUI

struct TargetView: View {
    @ObservedObject var cigarettesCount: Cigarettes_Count
    var themeColor: Color
    
    var progress: Double {
        guard cigarettesCount.targetCigarettes > 0 else { return 0 }
        return Double(cigarettesCount.countedCigarettes) / Double(cigarettesCount.targetCigarettes)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Today's Target")
                        .font(.headline)
                        .foregroundColor(themeColor)
                    
                    Spacer()
                    
                    Text("\(cigarettesCount.countedCigarettes) / \(cigarettesCount.targetCigarettes)")
                        .font(.headline)
                        .foregroundColor(themeColor)
                }
                .padding()
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(themeColor)
                    .padding()
                
            }
            .padding()
            .background(themeColor.opacity(0.3))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

struct TargetView_Previews: PreviewProvider {
    static var previews: some View {
        TargetView(cigarettesCount: Cigarettes_Count(), themeColor: .blue)
    }
}
