//
//  JourneyImpactGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import SwiftUI
import SwiftData

// Horizontal scrolling gallery to display insights about a single journey
struct JourneyImpactGalleryView: View {
    @Query private var journeys: [Journey]
    @StateObject private var viewModel = JourneyImpactViewModel()
    
    let journey: Journey
    
    var body: some View {
        VStack {
            
            HStack {
                JourneyImpactListItemView(impactType: viewModel.impactTypes[0], journey: journey, allJourneys: journeys)
                
                JourneyImpactListItemView(impactType: viewModel.impactTypes[1], journey: journey, allJourneys: journeys)
            }
            
            if viewModel.alternateTransport != nil {
                JourneyAlternateTransportView(journey: journey)
            }
            
        }
        .padding(.horizontal, 15)
        .onAppear {
            viewModel.suggestAlternateTransport(journey: journey)
        }
    }
}

