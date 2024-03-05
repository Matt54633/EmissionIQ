//
//  Ribbon.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import Foundation
import SwiftUI

// Ribbon creates the tails for a ribbon shape
struct Ribbon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: 0.99957*width, y: height))
        path.addLine(to: CGPoint(x: 0.91709*width, y: height))
        path.addLine(to: CGPoint(x: 0.77863*width, y: height))
        path.addLine(to: CGPoint(x: 0.77863*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.77863*width, y: 0))
        path.addLine(to: CGPoint(x: 0.91709*width, y: 0))
        path.addLine(to: CGPoint(x: 0.99957*width, y: 0))
        path.addLine(to: CGPoint(x: 0.95427*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.99957*width, y: height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: 0.08248*width, y: height))
        path.addLine(to: CGPoint(x: 0.22094*width, y: height))
        path.addLine(to: CGPoint(x: 0.22094*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.22094*width, y: 0))
        path.addLine(to: CGPoint(x: 0.08248*width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0.0453*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}
