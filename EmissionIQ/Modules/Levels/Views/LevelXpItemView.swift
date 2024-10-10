//
//  LevelXpItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LevelXPItemView displays each individual view that forms the LevelXPView. e.g. level XP, total XP
struct LevelXpItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var value: String?
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.listItemBackground)
            VStack {
                if let value = value {
                    Text(value)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                
                Text(title)
                    .font(.caption)
            }
            .padding(EdgeInsets(top: 12.5, leading: 2.5, bottom: 12.5, trailing: 2.5))
        }
    }
}

#Preview {
    LevelXpItemView(title: "Level", value: nil)
}
