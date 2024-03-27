//
//  LevelIndicatorView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData
import Combine

// View to display the users' level and progress for that level
struct LevelIndicatorView: View {
    @Query private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var context
    @StateObject private var viewModel = LevelViewModel.shared
    @StateObject private var trophiesViewModel = TrophiesViewModel()
    @StateObject private var levelManager = LevelManager.shared
    @State private var currentLevel: Int?
    @State private var displaySheet: Bool = false
    
    let displayOuter: Bool
    let frameWidth: Double
    let progressWidth: Double
    let fontSize: Int
    
    var body: some View {
        ZStack {
            
            if !displayOuter {
                Circle()
                    .fill(Color(.systemBackground))
                    .frame(maxWidth: frameWidth + 10)
            }
            
            if let level = levelManager.level, let xp = levelManager.xp {
                let levelProgress = Double(xp % 1000) / 1000
                
                if displayOuter {
                    LevelProgressView(progress: 1.0, color: colorScheme == .dark ? Color.white.opacity(0.4) : .lightGrey.opacity(0.5), strokeWidth: progressWidth, frameWidth: frameWidth)
                }
                
                LevelProgressView(progress: levelProgress, color: .primaryGreen, strokeWidth: progressWidth, frameWidth: frameWidth)
                
                LevelTextView(level: level, fontSize: fontSize, color: colorScheme == .dark ? .white : .black)
                
            } else {
                
                if displayOuter {
                    LevelProgressView(progress: 1.0, color: colorScheme == .dark ? Color.white.opacity(0.5) : Color(.gray).opacity(0.5), strokeWidth: progressWidth, frameWidth: frameWidth)
                }
                
                LevelTextView(level: 0, fontSize: fontSize, color: colorScheme == .dark ? .white : .black)
                
            }
        }
        .sheet(isPresented: $displaySheet) {
            if let level = levelManager.level {
                LevelUpView(level: level)
            }
        }
        .onAppear {
            Task {
                try await _ = levelManager.fetchLevelAndXP()
                currentLevel = levelManager.level
            }
            
        }
        .onChange(of: levelManager.level) {
            if let level = levelManager.level, let currentLevel = currentLevel, level > currentLevel {
                displaySheet = true
                trophiesViewModel.updateTrophies(trophies: trophies, journeys: journeys, readArticles: readArticles, context: context)
            }
        }
        .onChange(of: levelManager.xp) {
            if let level = levelManager.level, let xp = levelManager.xp {
                Task {
                    await viewModel.setUserAttributes(level: level, xp: xp)
                    trophiesViewModel.updateTrophies(trophies: trophies, journeys: journeys, readArticles: readArticles, context: context)
                }
            }
            
        }
    }
}

#Preview {
    LevelIndicatorView(displayOuter: true, frameWidth: 100, progressWidth: 8, fontSize: 32)
}
