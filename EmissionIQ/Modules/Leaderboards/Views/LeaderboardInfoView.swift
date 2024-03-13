//
//  LeaderboardInfoView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 13/03/2024.
//

import SwiftUI

struct LeaderboardInfoView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    let leaderboardType: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            HStack {
                
                Image(systemName: viewModel.setLeaderboardImage(leaderboardType: leaderboardType))
                    .font(.caption)
                    .foregroundStyle(.primaryGreen)
                
                Text(leaderboardType.capitalized)
                    .font(.headline)
                
            }
            .fontWeight(.semibold)
            
            Text(viewModel.setInfoText(leaderboardType: leaderboardType))
                .font(.subheadline)
            
        }
        .padding()
    }
}

#Preview {
    LeaderboardInfoView(viewModel: LeaderboardViewModel(), leaderboardType: "impact")
}
