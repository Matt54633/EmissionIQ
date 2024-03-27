//
//  SearchDisplayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 09/03/2024.
//

import SwiftUI
import SwiftData
import MapKit

// View to display search page for searching locations
struct SearchDisplayView: View {
    @Query(sort: \Location.creationDate, order: .reverse) private var recentLocations: [Location]
    @Environment(\.modelContext) private var context
    @StateObject private var searchViewModel = SearchViewModel()
    @ObservedObject var addJourneyViewModel: AddJourneyViewModel
    @State private var searchText: String = ""
    @FocusState private var searchInFocus: Bool
    @Binding var displaySearchSheet: Bool
    @Binding var inputText: String
    
    var locationType: String
    
    var body: some View {
        VStack {
            
            SearchBarView(searchText: $searchText)
                .focused($searchInFocus)
                .onAppear {
                    searchInFocus = true
                    searchViewModel.locationNames.removeAll()
                }
            
            List {
                if !recentLocations.isEmpty && searchText == "" {
                    
                    Section("Recent Locations") {
                        RecentResultsListView(addJourneyViewModel: addJourneyViewModel, searchViewModel: searchViewModel, displaySearchSheet: $displaySearchSheet, inputText: $inputText, recentLocations: recentLocations, locationType: locationType)
                    }
                    
                }
                
                SearchResultsListView(addJourneyViewModel: addJourneyViewModel, searchViewModel: searchViewModel, displaySearchSheet: $displaySearchSheet, inputText: $inputText, locations: searchViewModel.locationNames, locationType: locationType, recentLocations: recentLocations)
            }
            .listStyle(.inset)
            
        }
        .modifier(RoundedSheet(radius: 25, height: .large))
        .onChange(of: searchText) { _, newValue in
            searchViewModel.searchSubject.send(newValue)
        }
    }
}

#Preview {
    SearchDisplayView(addJourneyViewModel: AddJourneyViewModel(), displaySearchSheet: .constant(true), inputText: .constant(""), locationType: "start")
}
