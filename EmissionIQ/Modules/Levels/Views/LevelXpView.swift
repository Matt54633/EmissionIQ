//
//  LevelXpView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// Display both XP for the current level and total XP
struct LevelXpView: View {
    @StateObject private var levelManager = LevelManager.shared
    
    var body: some View {
        HStack {
            
            LevelXpItemView(title: "Level XP", value: "\(String(levelManager.xp ?? 0)) / 1000")
            
            LevelXpItemView(title: "Total XP", value:  String((levelManager.level ?? 0) * 1000 + (levelManager.xp ?? 0)))
            
        }
        .onAppear {
            if levelManager.xp == nil || levelManager.level == nil {
                Task {
                    try await levelManager.fetchLevelAndXP()
                }
            }
        }
    }
}

#Preview {
    LevelXpView()
}
