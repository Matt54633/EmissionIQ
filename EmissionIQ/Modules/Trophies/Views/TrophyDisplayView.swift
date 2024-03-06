//
//  TrophyDisplayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to diplay trophy details and 3D model
struct TrophyDisplayView: View {
    let trophy: Trophy
    
    var body: some View {
        ZStack {
            
            UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 25, bottomTrailingRadius: 25, topTrailingRadius: 0).fill(Color(trophy.rank.capitalized))
                .brightness(trophy.rank == "silver" ? -0.3 : (trophy.rank == "gold" ? -0.15 : (trophy.rank == "bronze" ? 0 : -0.05)))
            
            VStack {
                
                Spacer()
                
                TrophyView(trophyType: trophy.rank.capitalized)
                    .frame(width: 350, height: 350)
                
                Spacer()
                
                
                Text(trophy.name)
                    .font(.largeTitle)
                
                HStack {
                    
                    Group {
                        Text(trophy.desc)
                        
                        Text("\(trophy.dateAchieved.shortFormattedDate)")
                    }
                    .padding(EdgeInsets(top: 7.5, leading: 12.5, bottom: 7.5, trailing: 12.5))
                    .background(Capsule().fill(.white.opacity(0.25)))
                    
                }
                .padding(.bottom)
                
            }
            .padding()
        }
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding(.bottom)
        .ignoresSafeArea(edges: [.horizontal, .top])
    }
}

#Preview {
    TrophyDisplayView(trophy: Trophy(name: "First Journey", desc: "Complete 1 journey", goal: "Travel 50 miles", type: "Journey", rank: "gold", isAchieved: true, dateAchieved: Date()))
}
