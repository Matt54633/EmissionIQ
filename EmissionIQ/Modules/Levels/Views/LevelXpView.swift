//
//  LevelXpView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// Display both XP for the current level and total XP
struct LevelXpView: View {
    @ObservedObject var viewModel: LevelViewModel
    
    var body: some View {
        HStack {
            
            LevelXpItemView(title: "Level XP", value: "\(String(viewModel.xp ?? 0)) / 1000")
            
            LevelXpItemView(title: "Total XP", value:  String((viewModel.level ?? 0) * 1000 + (viewModel.xp ?? 0)))
            
        }
        .onAppear {
            if viewModel.xp == nil || viewModel.level == nil {
                viewModel.fetchLevelAndXp()
            }
        }
    }
}

#Preview {
    LevelXpView(viewModel: LevelViewModel())
}
