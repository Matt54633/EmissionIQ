//
//  LeaderboardPodiumMedalView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LeaderboardPodiumMedalView displays the medal for a given podium placing
struct LeaderboardPodiumMedalView: View {
    let color: Color
    
    var body: some View {
        Circle()
            .fill(color)
            .stroke(Color(.systemBackground), lineWidth: 5)
            .frame(width: 65)
    }
}

#Preview {
    LeaderboardPodiumMedalView(color: .gold)
}
