//
//  LeaderboardPodiumBackgroundView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LeaderboardPodiumBackgroundView displays the background for a given podium placing
struct LeaderboardPodiumBackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: LeaderboardViewModel
    
    let leaderboardType: String
    let userId: String?
    let item: (userId: String, value: Int)
    let index: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
                .frame(height:  viewModel.heightMultiplier(index: index))
            
            LeaderboardPodiumUserView(viewModel: viewModel, colorScheme: colorScheme, leaderboardType: leaderboardType, userId: userId, item: item, index: index)
            
        }
        .padding(.top, -40)
    }
}

#Preview {
    LeaderboardPodiumBackgroundView(viewModel: LeaderboardViewModel(), leaderboardType: "Journeys", userId: "User 10", item: ("User 10", 10), index: 1)
}
