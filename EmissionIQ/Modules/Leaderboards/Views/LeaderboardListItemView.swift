//
//  LeaderboardListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 24/03/2024.
//

import SwiftUI

// Display an available leaderboard to navigate to
struct LeaderboardListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: LeaderboardViewModel
    @State private var userPosition: Int?
    
    let leaderboardType: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Image(systemName: viewModel.setLeaderboardImage(leaderboardType: leaderboardType))
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.primaryGreen)
                    
                    Spacer()
                    
                    Text(viewModel.userPositions[leaderboardType] ?? "Pos")
                        .font(.title2)
                        .fontWeight(.bold)
                        .redacted(reason: viewModel.userPositions[leaderboardType] == nil ? .placeholder : [])
                        .onChange(of: viewModel.userId) {
                            if viewModel.userId != nil {
                                Task {
                                    try await viewModel.fetchDataAndCalculatePosition(for: leaderboardType)
                                }
                            }
                        }
                        .onAppear {
                            if viewModel.userId != nil {
                                Task {
                                    try await viewModel.fetchDataAndCalculatePosition(for: leaderboardType)
                                }
                            }
                        }
                    
                }
                .padding(.bottom)
                
                HStack {
                    
                    Text(leaderboardType == "xp" ? leaderboardType.uppercased() : (leaderboardType == "daysActive" ? "Days Active" : leaderboardType.capitalized))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    
                }
                .fontWeight(.semibold)
            }
            .padding()
        }
    }
}

#Preview {
    LeaderboardListItemView(viewModel: LeaderboardViewModel(), leaderboardType: "journeys")
}
