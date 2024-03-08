//
//  LevelUpView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display when the user levels up, displays the new level and confetti animation
struct LevelUpView: View {
    @StateObject private var viewModel = LevelViewModel.shared
    let level: Int
    
    var body: some View {
        ZStack {
            
            Rectangle().fill(.primaryGreen)
            
            LevelConfettiView(currentLevel: $viewModel.levelUpLevel, viewModel: viewModel)
            
            VStack {
                
                Text("Level Up!")
                    .padding(.vertical)
                    .font(.title)
                
                Spacer()
                
                LevelCounterView(viewModel: viewModel, level: level)
                
                Spacer()
                
                Text("Keep up the good work!")
                    .font(.title2)
                    .padding(.bottom)
                
            }
            .padding()
        }
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .modifier(RoundedSheet(radius: 25, height: .medium))
        .ignoresSafeArea(.all)
    }
}

#Preview {
    LevelUpView(level: 5)
}
