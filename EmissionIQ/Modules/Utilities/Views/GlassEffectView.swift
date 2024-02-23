//
//  GlassEffectView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import SwiftUI

// GlassEffect is used to create a glass like blur over the top of an image
struct GlassEffectView: View {
    let image: String
    let cornerRadius: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image(image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(.ultraThinMaterial)
                .colorScheme(.dark)
        }
    }
}

#Preview {
    GlassEffectView(image: "LeaderboardBackground", cornerRadius: 25)
}
