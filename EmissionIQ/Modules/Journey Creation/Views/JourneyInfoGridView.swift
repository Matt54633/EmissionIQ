//
//  JourneyInfoGridView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// JourneyInfoGridView displays the info section views in a vertical stacked grid
struct JourneyInfoGridView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                JourneyInfoSectionView(title: "Return Journeys",
                                images: ["arrow.left.arrow.right"],
                                description: "To add a return journey, simply tap the green arrow indicator to switch from a single journey to a return.")
                
                JourneyInfoSectionView(title: "Cars, Walks and Bikes",
                                images: ["car.fill", "figure.walk", "bicycle"],
                                description: "For these transport modes, Apple Maps routing is used to determine the most suitable route.")
                
                JourneyInfoSectionView(title: "Buses and Rail",
                                images: ["bus.fill", "tram.fill"],
                                description: "For these transport modes, Google Maps' Distance Matrix API is used to determine the most suitable route.")
                
                JourneyInfoSectionView(title: "Flights and Ferries",
                                images: ["airplane", "ferry.fill"],
                                description: "For these transport modes, the distance is calculated as the point to point distance between locations.")
                
                JourneyInfoSectionView(title: "Distance Unavailable",
                                images: ["exclamationmark.circle.fill"],
                                description: "If the distance is unavailable between your two chosen locations, an additional field will be displayed to allow for a manual input.")
                
            }
        }
    }
}

#Preview {
    JourneyInfoGridView()
}
