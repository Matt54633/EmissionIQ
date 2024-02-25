//
//  PillText.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// View modifier to style pill text views
struct PillText: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.medium)
            .padding(EdgeInsets(top: 7.5, leading: 15, bottom: 7.5, trailing: 15))
            .background(Capsule().fill(Color(.tertiarySystemBackground)).shadow(color: Color.black.opacity(0.2), radius: 2.5, x: 0, y: 2))
            .padding(10)
    }
}
