//
//  TrophyUnlockedView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display on a trophy list item when unlocked
struct TrophyUnlockedView: View {
    @Environment(\.colorScheme) var colorScheme
    let trophy: Trophy
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                HStack(alignment: .center) {
                    
                    ZStack {
                        
                        Image(systemName: "trophy.fill")
                            .foregroundStyle(Color(trophy.rank.capitalized))
                        
                    }
                    .font(.title)
                    .padding(.trailing, 2.5)
                    
                    Text(trophy.name.split(separator: " ").joined(separator: "\n"))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                    
                }
                
                Spacer()
                
                HStack {
                    
                    Text(trophy.dateAchieved.shortFormattedDate)
                        .font(.subheadline)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .background(Capsule().fill(colorScheme == .dark ? .white.opacity(0.25) : .lightGrey.opacity(0.18)))
                    
                    Image(systemName: "chevron.right")
                    
                }
                .fontWeight(.semibold)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    }
}
