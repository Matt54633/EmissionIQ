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
            
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            VStack {
                if let value = value {
                    Text(value)
                        .font(.system(size: 19))
                        .fontWeight(.semibold)
                }
                
                Text(title)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    LevelXpItemView(title: "Level", value: nil)
}
