//
//  LevelTextView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LevelTextView displays the text for the current user level
struct LevelTextView: View {
    var level: Int?
    var fontSize: Int
    var color: Color
    
    var body: some View {
        
        Text(String(level ?? 0))
            .font(.system(size: CGFloat(fontSize), weight: .bold))
            .foregroundStyle(color)
        
    }
}

#Preview {
    LevelTextView(level: 10, fontSize: 44, color: .black)
}
