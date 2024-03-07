//
//  LeaderboardItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display leaderboard items that are not podium items
struct LeaderboardItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: LeaderboardViewModel
    
    let leaderboardType: String
    let index: Int
    let item: (userId: String, value: Int)
    let userId: String?
    
    var body: some View {
        let isCurrentUser = item.userId == userId
        
        HStack {
            
            LeaderboardRankView(isCurrentUser: isCurrentUser, rank: viewModel.ordinalNumberString(from: index))
            
            LeaderboardUserView(isCurrentUser: isCurrentUser, userId: item.userId, value: item.value, unit: viewModel.setLeaderboardUnit(leaderboardType: leaderboardType))
            
        }
        .font(.title2)
        .frame(height: 40)
        
    }
}

#Preview {
    LeaderboardItemView(viewModel: LeaderboardViewModel(), leaderboardType: "Levels", index: 8, item: ("User 10", 10), userId: "User 11")
}
