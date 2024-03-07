//
//  WavyRectangle.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import Foundation
import SwiftUI

// Custom shape that creates a rectangle with a wavy bottom edge
struct WavyRectangle: Shape {
    var amplitude: CGFloat = 15
    var waveCount: Int    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let stepX = rect.width / CGFloat(waveCount)
        let stepY = amplitude
        
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        for i in 0..<waveCount {
            let index = CGFloat(i) * stepX
            path.addQuadCurve(
                to: CGPoint(x: index + stepX, y: rect.height),
                control: CGPoint(x: index + stepX / 2, y: rect.height - stepY * (i % 2 == 0 ? 1 : -1))
            )
        }
        
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        return path
    }
}

