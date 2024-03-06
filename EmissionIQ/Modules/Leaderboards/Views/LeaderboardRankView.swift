//
//  LeaderboardRankView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LeaderboardRankView displays the users rank
struct LeaderboardRankView: View {
    let isCurrentUser: Bool
    let rank: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(isCurrentUser ? .primaryGreen : .lightGrey.opacity(0.5))
                .frame(width: 70)
            
            Text(rank)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(isCurrentUser ? .white : .primary)
        }
    }
}

#Preview {
    LeaderboardRankView(isCurrentUser: false, rank: "1st")
}
