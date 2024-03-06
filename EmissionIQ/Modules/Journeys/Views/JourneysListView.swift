//
//  JourneysListView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to create a list of a users' journeys
struct JourneysListView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject private var journeyListViewModel = JourneysListViewModel()
    @ObservedObject var addJourneyViewModel: AddJourneyViewModel
    
    var journeys: [Journey]
    var context: ModelContext
    
    var body: some View {
        List {
            ForEach(journeyListViewModel.groupJourneysByWeek(journeys: journeys), id: \.0) { week, journeys in
                
                Section(header: Text("\(week.weekFormattedDate) - \(week.endOfWeek.weekFormattedDate)").modifier(ListSectionTag())) {
                    
                    ForEach(journeys, id: \.self) { journey in
                        NavigationLink {
                            JourneyView(journey: journey)
                        } label: {
                            JourneyListItemView(journey: journey)
                                .swipeActions {
                                    Button("Delete") {
                                        addJourneyViewModel.deleteJourney(journey: journey, context: context)
                                    }
                                    .tint(.red)
                                }
                        }
                        .listRowBackground(colorScheme == .dark ? Color(.tertiarySystemBackground).opacity(0.75) : Color(.secondarySystemBackground))
                    }
                    
                }
            }
        }
        .background(Color(.systemBackground))
        .scrollContentBackground(.hidden)
        .padding(.top, horizontalSizeClass == .compact ? 15 : 30)
    }
}
