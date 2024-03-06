//
//  ReusableButtonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import SwiftUI

// ReusableButtonView is used to create a view that can be used as a button label
struct ReusableButtonView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let backgroundColour: Color
    let text: String
    let textColor: Color
    let opacity: Double
    let radius: CGFloat
    let disabled: Bool?
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: radius)
                .fill(disabled == true ? .lightGrey.opacity(0.25) : backgroundColour)
                .opacity(opacity)
            
            Text(text)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(disabled == true ? .gray : textColor)
               
        }
        .frame(height: 45)
        .padding(.bottom, horizontalSizeClass == .compact ? 0 : 15)
        
    }
}

#Preview {
    ReusableButtonView(backgroundColour: .red, text: "Add", textColor: .red, opacity: 0.5, radius: 15, disabled: nil)
}
