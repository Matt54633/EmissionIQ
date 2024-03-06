//
//  LeaderboardsGridView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LeaderboardsGridView displays the available leaderboards in a grid
struct LeaderboardsGridView: View {
    @ObservedObject var viewModel: LeaderboardViewModel
    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            
            ForEach(viewModel.leaderboardTypes, id: \.self) { type in
                NavigationLink {
                    LeaderboardView(viewModel: viewModel, leaderboardType: type)
                } label: {
                    LeaderboardListItemView(viewModel: viewModel, leaderboardType: type)
                }
                .tint(.primary)
            }
            
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
    }
}

#Preview {
    LeaderboardsGridView(viewModel: LeaderboardViewModel())
}
