//
//  DistanceOverrideView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// Display a manual distance field when computed distance is unavailable
struct DistanceOverrideView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var manualDistance: String
    
    var body: some View {
        TextField("Manual Distance", text: $manualDistance)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 22)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 15).fill(colorScheme == .dark ? .quinary : .quinary))
            .padding(.bottom, 20)
    }
}

#Preview {
    DistanceOverrideView(manualDistance: .constant("200"))
}
