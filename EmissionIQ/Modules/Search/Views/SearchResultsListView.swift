//
//  SearchResultsListView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import MapKit

// View to display the search results from a user search
struct SearchResultsListView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var addJourneyViewModel: AddJourneyViewModel
    @ObservedObject var searchViewModel: SearchViewModel
    @Binding var displaySearchSheet: Bool
    @Binding var inputText: String
    
    let locations: [MKPlacemark]
    let locationType: String
    let recentLocations: [Location]
    
    var body: some View {
        ForEach(locations, id: \.self) { location in
            SearchRowView(location: location)
                .onTapGesture {
                    addJourneyViewModel.setLocation(location: location, locationType: locationType, displaySearchSheet: $displaySearchSheet, inputText: $inputText)
                    searchViewModel.saveRecentLocation(recentLocations: recentLocations, location: location, context: context)
                }
        }
    }
}
