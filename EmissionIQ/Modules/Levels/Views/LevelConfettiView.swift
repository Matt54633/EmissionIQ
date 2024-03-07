//
//  LevelConfettiView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import Vortex

// View to display confetti when a user levels up
struct LevelConfettiView: View {
    @Binding var currentLevel: Int
    
    var body: some View {
        VortexViewReader { proxy in
            VortexView(.confetti) {
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 16, height: 16)
                    .tag("square")
                
                Circle()
                    .fill(.white)
                    .frame(width: 16)
                    .tag("circle")
                
            }
            .onChange(of: currentLevel) {
                if currentLevel < 3 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        proxy.burst()
                    }
                }
            }
        }
    }
}

#Preview {
    LevelConfettiView(currentLevel: .constant(2))
}
