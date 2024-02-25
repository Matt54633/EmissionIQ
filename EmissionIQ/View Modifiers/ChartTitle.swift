//
//  ChartTitle.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// View modifier to display chart title text views
struct ChartTitle: ViewModifier {
    let selectedDataPoint: (date: Date, value: Float)?
    
    func body(content: Content) -> some View {
        content
            .opacity(selectedDataPoint == nil ? 1 : 0.0)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(EdgeInsets(top: 22.5, leading: 20, bottom: -15, trailing: 20))
    }
}

