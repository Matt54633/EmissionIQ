//
//  CarbonOutputValueView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display the users' carbon output
struct CarbonOutputValueView: View {
    @Query private var journeys: [Journey]
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Text("\((String(format: "%.0f", journeys.calculateTotalEmissions())))")
                    .font(.system(size: 80)) +
                
                Text("kg CO₂e")
                    .font(.title2)
                
                Spacer()
                
            }
            .fontWeight(.bold)
            .padding(.bottom, -15)
            
            Text("Keep tracking your progress!")
                .font(.title3)
            
        }
        .foregroundStyle(.white)
        .padding(.bottom, 27.5)
        
    }
}
