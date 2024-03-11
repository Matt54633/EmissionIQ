//
//  TrophyAchievedView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 18/03/2024.
//

import SwiftUI

// View to display when a user achieves a trophy
struct TrophyAchievedView: View {
    @Binding var displayTrophyAchievedView: Bool
    let trophy: Trophy
    
    var body: some View {
        ZStack {
            GlassEffectView(image: "GreenMesh", cornerRadius: 20)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
            
            HStack {
                
                VStack(alignment: .leading) {
                    
                    Text("Trophy Unlocked")
                        .font(.caption)
                        .fontWeight(.medium)
                        .textCase(.uppercase)
                    
                    Text(trophy.name)
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }
                
                Spacer()
                
                Image(systemName: "trophy.fill")
                    .font(.title)
                    .foregroundStyle(Color(trophy.rank.capitalized))
                
                Image(systemName: "chevron.right")
                
            }
            .padding()
        }
        .foregroundStyle(.white)
        .padding()
        .frame(height: 90)
        .offset(y: displayTrophyAchievedView == true ? 0 : -300)
        .animation(.spring(duration: 0.6), value: displayTrophyAchievedView)
        .gesture(DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onEnded { value in
                if value.translation.height < 0 {
                    displayTrophyAchievedView = false
                }
            }
        )
    }
}

#Preview {
    TrophyAchievedView(displayTrophyAchievedView: .constant(true), trophy: Trophy(name: "First Journey", desc: "Complete 1 journey", goal: "Travel 50 miles", type: "Journey", rank: "gold", isAchieved: true, dateAchieved: Date()))
}
