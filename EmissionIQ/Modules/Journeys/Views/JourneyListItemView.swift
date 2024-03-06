//
//  JourneyListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display details about a journey when displayed in a list format
struct JourneyListItemView: View {
    var journey: Journey
    
    var body: some View {
        HStack {
            
            Image(systemName: journey.imageName)
                .font(.title3)
                .fontWeight(.regular)
                .foregroundStyle(.primaryGreen)
                .frame(width: 27.5)
                .padding(.trailing,2.5)
            
            VStack(alignment: .leading) {
                
                Text(journey.startLocationName)
                
                Text(journey.endLocationName)
                
            }
            .font(.subheadline)
            .lineLimit(1)
            
            Spacer()
            
            VStack {
                Text(String(format: "%.1f", Double(journey.carbonProduced)))
                    .font(.subheadline)
                
                Text("kg CO₂e")
                    .font(.caption)
                    .fontWeight(.regular)
            }
            
        }
        .fontWeight(.semibold)
    }
}
