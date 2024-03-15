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
    @StateObject var levelViewModel = LevelViewModel.shared
    @StateObject private var networkManager = NetworkManager()

    var body: some View {
        VStack {
            if !journeys.isEmpty {
                ScrollView {
                    
                    VStack {
                        
                        LevelIndicatorView(displayOuter: true, frameWidth: 190, progressWidth: 12, fontSize: 72)
                        
                        LevelUserRibbonView()
                            .frame(height: 50)
                        
                        LevelXpView()
                        
                        StatsGridView()
                    }
                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
                    
                }
                .modifier(ConditionalPadding())
                
            } else {
                JourneyMessageView()
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !networkManager.isConnected {
                   NetworkConnectionView()
                }
            }
        }
    }
}

#Preview {
    LevelView()
}
