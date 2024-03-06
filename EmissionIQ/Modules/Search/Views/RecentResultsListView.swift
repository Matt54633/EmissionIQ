//
//  RecentResultsListView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import MapKit

// View to display the user's 5 most recent locations
struct RecentResultsListView: View {
    @ObservedObject var addJourneyViewModel: AddJourneyViewModel
    @ObservedObject  var searchViewModel: SearchViewModel
    @Binding var displaySearchSheet: Bool
    @Binding var inputText: String
    
    var recentLocations: [Location]
    var locationType: String
    
    var body: some View {
        ForEach(recentLocations, id: \.self) { location in
            SearchRecentRowView(location: location)
                .onTapGesture {
                    location.creationDate = Date()
                    searchViewModel.convertToPlacemark(location: location, locationType: locationType) { placemark in
                        if let placemark = placemark {
                            addJourneyViewModel.setLocation(location: MKPlacemark(placemark: placemark), locationType: locationType, displaySearchSheet: $displaySearchSheet, inputText: $inputText)
                        }
                        displaySearchSheet = false
                    }
                }
        }
    }
}
