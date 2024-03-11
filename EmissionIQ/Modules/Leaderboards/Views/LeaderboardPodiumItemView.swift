//
//  LeaderboardPodiumItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 26/03/2024.
//

import SwiftUI

// View to display leaderboard items that are on the podium
struct LeaderboardPodiumItemView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    
    let leaderboardType: String
    let userId: String?
    let item: (userId: String, value: Int)
    let index: Int
    
    var body: some View {
        VStack {
            
            LeaderboardPodiumMedalView(color: viewModel.colorForPosition(index))
            
            LeaderboardPodiumBackgroundView(viewModel: viewModel, leaderboardType: leaderboardType, userId: userId, item: item, index: index)
            
        }
        .padding(2)
    }
}

#Preview {
    LeaderboardPodiumItemView(viewModel: LeaderboardViewModel(), leaderboardType: "Journeys", userId: "User 10", item: ("User 10", 2), index: 0)
}
