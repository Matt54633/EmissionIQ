//
//  LeaderboardView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 24/03/2024.
//

import SwiftUI

// Display an individual leaderboard for a given type
struct LeaderboardView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    @StateObject var networkManager = NetworkManager()
    @State private var displayInfoSheet: Bool = false
    let leaderboardType: String
    
    var body: some View {
        VStack {
            if let data = viewModel.leaderboardData[leaderboardType] {
                
                ScrollView {
                    
                    VStack(alignment: .center) {
                        
                        
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
                    .padding()
                }
            } else {
                LoadingView()
            }
            
            LeaderboardMotivatorView(viewModel: viewModel, leaderboardType: leaderboardType)
            
        }
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                if !networkManager.isConnected {
                    NetworkConnectionView()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    displayInfoSheet = true
                } label: {
                    Image(systemName: "info.circle")
                        .fontWeight(.semibold)
                        .foregroundStyle(.primaryGreen)
                }
                .popover(isPresented: $displayInfoSheet) {
                    LeaderboardInfoView(viewModel: viewModel, leaderboardType: leaderboardType)
                        .presentationCompactAdaptation(.popover)
                }
            }
            
        }
        .modifier(ConditionalPadding())
        .navigationTitle((leaderboardType == "xp" ? leaderboardType.uppercased() : (leaderboardType == "daysActive" ? "Days Active" : leaderboardType.capitalized)))
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            if viewModel.leaderboardData[leaderboardType] == nil {
                Task {
                    try await viewModel.userIdFetch()
                    try await  viewModel.fetchData(for: leaderboardType)
                }
            }
        }
        .refreshable {
            Task {
                try await viewModel.userIdFetch()
                try await  viewModel.fetchData(for: leaderboardType)
            }
        }
        
    }
}

#Preview {
    LeaderboardView(viewModel: LeaderboardViewModel(), leaderboardType: "distance")
}

