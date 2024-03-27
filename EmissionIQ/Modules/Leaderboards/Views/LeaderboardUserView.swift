//
//  LeaderboardUserView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/03/2024.
//

import SwiftUI

// LeaderboarduserView displays the users' ID and value
struct LeaderboardUserView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let isCurrentUser: Bool
    let userId: String
    let value: Int
    let unit: String?
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            HStack {
                
                Text(isCurrentUser ? "You" : userId)
                    .font(.body)
                    .fontWeight(isCurrentUser ? .bold : .regular)
                    .foregroundStyle(isCurrentUser ? .primaryGreen : .primary)
                
                Spacer()
                
                HStack(alignment: .firstTextBaseline) {
                    
                    Text("\(value)")
                        .fontWeight(.semibold)
                    + Text(unit ?? "")
                        .font(.caption)
                    
                }
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    LeaderboardUserView(isCurrentUser: false, userId: "FierceLion28", value: 20, unit: nil)
}
