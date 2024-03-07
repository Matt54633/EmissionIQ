//
//  LeaderboardsView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// Display a list of available leaderboards
struct LeaderboardsView: View {
    @Query private var journeys: [Journey]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject private var viewModel = LeaderboardViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                PageHeaderView(pageTitle: "Leaderboards") {
                    NavigationLink {
                        LevelView()
                    } label: {
                        LevelIndicatorView(displayOuter: false, frameWidth: 32, progressWidth: 4, fontSize: 17)
                    }
                }
                .frame(height: horizontalSizeClass == .compact ? 75 : 90)
                .onAppear {
                    Task {
                        try await viewModel.userIdFetch()
                    }
                }
                
                VStack {
                    
                    if !journeys.isEmpty {
                        ScrollView {
                            
                            GalleryHeaderView(image: "sparkles", title: "Keep it up!", displayNavIndicator: false, topPadding: 0)
                            
                            LeaderboardsGridView( viewModel: viewModel)
                            
                        }
                        .padding(.top, horizontalSizeClass == .compact ? 15 : 30)
                    }
                    else {
                        JourneyMessageView()
                    }
                }
                .modifier(ConditionalPadding())
                
            }
        }
    }
}

#Preview {
    LeaderboardsView()
}
