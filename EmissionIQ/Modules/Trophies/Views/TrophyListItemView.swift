//
//  TrophyListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 17/03/2024.
//

import SwiftUI
import SwiftData

// View to display a single trophy list item
struct TrophyListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var displayTrophySheet: Bool = false
    
    let trophy: Trophy
    
    var body: some View {
        Button {
            if trophy.isAchieved {
                displayTrophySheet = true
            }
        } label: {
            ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(colorScheme == .dark ? .quaternary : .quinary)
                
                VStack {
                    if trophy.isAchieved {
                        TrophyUnlockedView(trophy: trophy)
                    } else {
                        TrophyLockedView(trophy: trophy)
                    }
                }
                
            }
            .frame(height: 60)
            .navigationDestination(isPresented: $displayTrophySheet) {
                TrophyDisplayView(trophy: trophy)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15))
            .buttonStyle(PlainButtonStyle())
        }
        
    }
}

#Preview {
    TrophyListItemView(trophy: Trophy(name: "First Journey", desc: "Complete 1 journey", goal: "Travel 50 miles", type: "Journey", rank: "bronze", isAchieved: false, dateAchieved: Date()))
}
