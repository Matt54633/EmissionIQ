//
//  JourneysListAddButtonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to create an add button on the Journeys View
struct JourneysListAddButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(.primaryGreen)
                .frame(height: 55)
            
            Image(systemName: "plus")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .black : .white)
            
        }
    }
}

#Preview {
    JourneysListAddButtonView()
}
