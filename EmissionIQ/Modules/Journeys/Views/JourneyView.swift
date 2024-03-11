//
//  JourneyView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 04/03/2024.
//

import SwiftUI

// View to display all details about a single Journey
struct JourneyView: View {
    @StateObject private var viewModel = JourneyViewModel()
    var journey: Journey
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                JourneyLocationsView(journey: journey)
                
                JourneyDetailsView(journey: journey)
                
                JourneyImpactGalleryView(journey: journey)
                
                JourneyMapView(viewModel: viewModel, startCoord: journey.startCoordinate, endCoord: journey.endCoordinate, journey: journey)
                
            }
            .modifier(ConditionalPadding())
            .toolbar {
                JourneyDeleteButtonView(journey: journey)
            }
            
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}
