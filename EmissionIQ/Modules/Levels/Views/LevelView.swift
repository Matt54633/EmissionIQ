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
    @StateObject var viewModel = StatsViewModel()
    @State private var displayView = false
    
    
    
    var body: some View {
        if !journeys.isEmpty {
            VStack {
                
                if displayView {
                    Group {
                        
                        if UIScreen.current?.bounds.height ?? 600 > 700 {
                            LevelIndicatorView(displayOuter: true, frameWidth: 200, progressWidth: 12, fontSize: 72)
                        } else {
                            LevelIndicatorView(displayOuter: true, frameWidth: 100, progressWidth: 6, fontSize: 36)
                        }
                        
                        LevelUserRibbonView(viewModel: viewModel)
                            .frame(height: 50)
                        
                        LevelXpView()
                        
                        StatsGalleryView(viewModel: viewModel)
                    }
                    .transition(.scale)
                }
                
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
            .modifier(ConditionalPadding())
            .onAppear {
                Task {
                    await viewModel.fetchUserId()
                    await viewModel.fetchUserCreationDate()
                }
                
                withAnimation(.spring().delay(0.35)) {
                    displayView = true
                }
            }
        } else {
            JourneyMessageView()
        }
    }
}

#Preview {
    LevelView()
}
