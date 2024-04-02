//
//  RecentResultsListView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 09/03/2024.
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
            
            Button {
                displaySearchSheet = false
                
                searchViewModel.convertToPlacemark(location: location, locationType: locationType) { placemark in
                    if let placemark = placemark {
                        
                        location.creationDate = Date()
                        
                        addJourneyViewModel.setLocation(location: MKPlacemark(placemark: placemark), locationType: locationType, displaySearchSheet: $displaySearchSheet, inputText: $inputText)
                        
                    }
                    
                }
                
            } label: {
                SearchRecentRowView(location: location)
            }
            
        }
    }
}

#Preview {
    RecentResultsListView(addJourneyViewModel: AddJourneyViewModel(), searchViewModel: SearchViewModel(), displaySearchSheet: .constant(true), inputText: .constant(""), recentLocations: [], locationType: "start")
}
