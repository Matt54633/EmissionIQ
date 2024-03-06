//
//  LevelXpView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// Display both XP for the current level and total XP
struct LevelXpView: View {
    @StateObject private var viewModel = LevelViewModel()
    
    var body: some View {
        HStack {
            
            if let xp = viewModel.xp, let level = viewModel.level {
                LevelXpItemView(title: "Level XP", value: "\(String(xp)) / 1000")
                LevelXpItemView(title: "Total XP", value:  String(level * 1000 + xp))
            } else {
                LevelXpItemView(title: "", value: nil)
                LevelXpItemView(title: "", value: nil)
            }
            
        }
        .frame(height: 65)
        .onAppear {
            if viewModel.xp == nil || viewModel.level == nil {
                viewModel.fetchLevelAndXp()
            }
        }
    }
}

#Preview {
    LevelXpView()
}
