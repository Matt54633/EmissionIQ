//
//  ReusableErrorView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 29/02/2024.
//

import SwiftUI

// ReusableErrorView displays an error message and can be customised to suit different contexts
struct ReusableErrorView: View {
    let backgroundColour: Color
    let text: String
    let textColor: Color
    let opacity: Double
    let radius: CGFloat
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: radius)
                .fill(backgroundColour)
                .opacity(opacity)
            
            HStack {
                
                Image(systemName: "exclamationmark.triangle.fill")
                
                Text(text)
                
            }
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(textColor)
            
        }
    }
}

#Preview {
    ReusableErrorView(backgroundColour: .red, text: "Error", textColor: .red, opacity: 0.25, radius: 15)
}
