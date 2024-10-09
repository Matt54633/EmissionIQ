//
//  JourneyLocationsView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import SwiftUI

// View to display a single journey's start and end location names
struct JourneyLocationsView: View {
    @Environment(\.colorScheme) var colorScheme
    let journey: Journey
    
    var body: some View {
        HStack {
            
            Image(systemName: "point.topleft.down.to.point.bottomright.curvepath")
                .font(.system(size: 56))
                .foregroundStyle(.primaryGreen)
                .padding(.trailing, 2.5)
            
            VStack(alignment: .leading) {
                
                Text(journey.startLocationName)
                    .lineLimit(1)
                    .padding(.bottom, 5)
                
                Text(journey.endLocationName)
                    .lineLimit(1)
                
            }
            .font(.title2)
            .fontWeight(.semibold)
            .lineLimit(2)
            
        }
        .padding()
    }
}
