//
//  LocationTextField.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// View modifier to style location inputs when adding a journey
struct LocationTextField: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    let paddingDirection: Alignment
    let radiusValues: [CGFloat]
    
    func body(content: Content) -> some View {
        content
            .clipped()
            .lineLimit(1)
            .padding(10)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, alignment: paddingDirection)
            .background(UnevenRoundedRectangle(topLeadingRadius: radiusValues[0], bottomLeadingRadius: radiusValues[1], bottomTrailingRadius: radiusValues[2], topTrailingRadius: radiusValues[3]).fill(colorScheme == .dark ? .quaternary : .quinary))
    }
}
