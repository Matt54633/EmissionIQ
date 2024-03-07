//
//  LeaderboardView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// Display an individual leaderboard for a given type
struct LeaderboardView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    let leaderboardType: String
    
    var body: some View {
        VStack {
            ScrollView {
                
                VStack(alignment: .center) {
                    
                    if let data = viewModel.data {
                        
                        let sortedData = Array(data.sorted { viewModel.setLeaderboardOrder(leaderboardType: leaderboardType) ? $0.value > $1.value : $0.value < $1.value }.enumerated())
                        
                        // podium views
                        HStack(alignment: .bottom) {
                            ForEach(sortedData.prefix(3), id: \.element.userId) { index, item in
                                LeaderboardPodiumItemView(viewModel: viewModel, leaderboardType: leaderboardType, userId: viewModel.userId, item: item, index: index)
                            }
                        }
                        
                        // regular leaderboard items
                        ForEach(sortedData.dropFirst(3), id: \.element.userId) { index, item in
                            LeaderboardItemView(viewModel: viewModel, leaderboardType: leaderboardType, index: index, item: item, userId: viewModel.userId)
                        }
                        
                    }
                    
                }
                .padding()
                .onAppear {
                    Task {
                        try await viewModel.userIdFetch()
                        try await  viewModel.fetchData(for: leaderboardType)
                    }
                }
                
                Spacer()
            }
            
            LeaderboardMotivatorView(viewModel: viewModel, leaderboardType: leaderboardType)
            
        }
        .modifier(ConditionalPadding())
        .navigationTitle((leaderboardType == "xp" ? leaderboardType.uppercased() : (leaderboardType == "daysActive" ? "Days Active" : leaderboardType.capitalized)))
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    LeaderboardView(viewModel: LeaderboardViewModel(), leaderboardType: "distance")
}

