//
//  TrophyLockedView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 18/03/2024.
//

import SwiftUI

// View to display on a trophy list item when locked
struct TrophyLockedView: View {
    @Environment(\.colorScheme) var colorScheme
    let trophy: Trophy
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                HStack {
                    
                    HStack(alignment: .center) {
                        
                        Image(systemName: "lock.fill")
                            .font(.title)
                            .padding(.trailing, 2.5)
                        
                        Text(trophy.name.split(separator: " ").joined(separator: "\n"))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        
                        Text(trophy.goal)
                            .font(.callout)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background(Capsule().fill(colorScheme == .dark ? .white.opacity(0.25) : .lightGrey.opacity(0.18)))
                        
                    }
                    .fontWeight(.semibold)
                }
                
            }
            .foregroundStyle(.gray)
            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }
    }
}

#Preview {
    TrophyLockedView(trophy: Trophy(name: "First Journey", desc: "Complete 1 journey", goal: "Travel 50 miles", type: "Journey", rank: "bronze", isAchieved: false, dateAchieved: Date()))
}
