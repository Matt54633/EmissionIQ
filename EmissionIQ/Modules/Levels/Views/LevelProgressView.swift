//
//  LevelProgressView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LevelProgressCircleView displays the progress wheel around the level text
struct LevelProgressView: View {
    var progress: Double
    var color: Color
    var strokeWidth: Double
    var frameWidth: Double
    
    var body: some View {
        Circle()
            .trim(from: 0, to: CGFloat(progress))
            .stroke(color, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
            .rotationEffect(Angle(degrees: 90))
            .frame(width: frameWidth)
    }
}

#Preview {
    LevelProgressView(progress: 0.8, color: .primaryGreen, strokeWidth: 6.0, frameWidth: 100.0)
}

