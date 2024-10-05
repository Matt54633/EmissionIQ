//
//  JourneysListAddButtonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 04/03/2024.
//

import SwiftUI

// View to create an add button on the Journeys View
struct JourneysListAddButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(.primaryGreen)
                .frame(height: 40)
            
            Image(systemName: "plus")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
        }
    }
}

#Preview {
    JourneysListAddButtonView()
}
