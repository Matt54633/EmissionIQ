//
//  JourneyDetailsView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 04/03/2024.
//

import SwiftUI

// View to display horizontal gallery of details about a single journey such as carbon outputted and distance etc.
struct JourneyDetailsView: View {
    let journey: Journey
    
    var body: some View {
        VStack {
            
            HStack(alignment: .center, spacing: 10) {
                
                JourneyDetailView(image: journey.imageName, value: "", label: journey.method.capitalized)
                
                JourneyDetailView(image: nil, value: String(format: "%.1f", journey.carbonProduced), label: "kg CO₂e")
                
                JourneyDetailView(image: nil, value: String(format: "%.1f", Double(journey.distance)), label: "Miles")
                
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 7.5, trailing: 15))
            .frame(height: 150)
            
            HStack {
                
                JourneyInfoItemView(image: "calendar", text: journey.date.shortFormattedDate)
                
                JourneyInfoItemView(image: journey.isReturn == true ? "arrow.left.arrow.right" : "arrow.right", text: journey.isReturn == true ? "Return" : "Single")
                
            }
            .padding(.horizontal)
            .frame(height: 45)
            
        }
    }
}
