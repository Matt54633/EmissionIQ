//
//  CarbonOutputValueView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import SwiftUI
import SwiftData

// View to display the users' carbon output
struct CarbonOutputValueView: View {
    @Query private var journeys: [Journey]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .firstTextBaseline, spacing: 3) {
                
                Text("\(journeys.calculateTotalEmissions() < 10000.0 ? String(format: "%.1f", journeys.calculateTotalEmissions()) : String(format: "%.0f", journeys.calculateTotalEmissions()))")
                    .font(.system(size: 70))
                
                Text("kg CO₂e")
                    .font(.title2)
                
                Spacer()
                
            }
            .fontWeight(.bold)
            .padding(.bottom, -10)
            
            Text("Keep tracking your progress!")
                .font(.headline)
                .fontWeight(.medium)
            
        }
        .foregroundStyle(.white)
        .padding(.bottom, 27.5)
        
    }
}
