//
//  LeaderboardPodiumUserView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LeaderboardPodiumUserView displays the details for a user for a given podium placing
struct LeaderboardPodiumUserView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    
    let colorScheme: ColorScheme
    let leaderboardType: String
    let userId: String?
    let item: (userId: String, value: Int)
    let index: Int
    
    var body: some View {
        ZStack {
            
            if item.userId == userId {
                RoundedRectangle(cornerRadius: 10)
                    .fill(viewModel.colorForPosition(index))
                    .frame(height: 65)
            }
            
            VStack {
                
                Text("\(item.value)")
                    .font(.system(size: 23))
                    .fontWeight(.semibold)
                
                + Text(viewModel.setLeaderboardUnit(leaderboardType: leaderboardType))
                    .font(.caption)
                
                Text(item.userId == userId ? "You" : item.userId)
                    .fontWeight(item.userId == userId ? .semibold : .regular)
                
            }
            .foregroundStyle(item.userId == userId ? (colorScheme == .dark ? .black : .white) : .primary)
            .padding(.bottom, item.userId == userId ? 0 : 6)
            
        }
    }
}

#Preview {
    LeaderboardPodiumUserView(viewModel: LeaderboardViewModel(), colorScheme: .dark, leaderboardType: "Journeys", userId: "User 10", item: ("User 10", 20), index: 1)
}
