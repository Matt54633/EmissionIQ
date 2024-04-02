//
//  LeaderboardMotivatorView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 24/03/2024.
//

import SwiftUI

// View to display motivational messages based on a user's leaderboard position
struct LeaderboardMotivatorView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    let leaderboardType: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            GlassEffectView(image: "GreenMesh", cornerRadius: 15)
                .frame(height: 50)
            
            HStack {
                
                Image(systemName: "sparkles")
                    .font(.title3)
                
                Spacer()
                
                Text(viewModel.motivationalMessage(for: viewModel.userPositions[leaderboardType] ?? "Keep it up!"))
                
            }
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding()
            
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 5, trailing: 15))
        
    }
}

#Preview {
    LeaderboardMotivatorView(viewModel: LeaderboardViewModel(), leaderboardType: "Distance")
}
