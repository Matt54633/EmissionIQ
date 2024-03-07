//
//  LevelView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display the users' level, XP and the User Level leaderboard
struct LevelView: View {
    @Query private var journeys: [Journey]
    @StateObject var statsViewModel = StatsViewModel()
    @StateObject var levelViewModel = LevelViewModel()
    @State private var displayView = false
    
    var body: some View {
        VStack {
            if !journeys.isEmpty {
                if displayView {
                    
                    ScrollView {
                        
                        VStack {
                            
                            LevelIndicatorView(displayOuter: true, frameWidth: 190, progressWidth: 12, fontSize: 72)
                            
                            LevelUserRibbonView(viewModel: statsViewModel)
                                .frame(height: 50)
                            
                            LevelXpView(viewModel: levelViewModel)
                            
                            StatsGridView(viewModel: statsViewModel)
                        }
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                        
                    }
                    .modifier(ConditionalPadding())
                    .transition(.opacity)
                    
                }
            } else {
                JourneyMessageView()
            }
            
        }
        .onAppear {
            levelViewModel.fetchLevelAndXp()
            
            Task {
                await statsViewModel.fetchUserId()
                await statsViewModel.fetchUserCreationDate()
            }
            
            withAnimation(.spring().delay(0.35)) {
                displayView = true
            }
        }
    }
}

#Preview {
    LevelView()
}
