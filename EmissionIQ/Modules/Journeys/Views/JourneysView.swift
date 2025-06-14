//
//  JourneysView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 04/03/2024.
//

import SwiftUI
import SwiftData

// View that displays a list of journeys, and allows a user to create new journeys
struct JourneysView: View {
    @Query(sort: \Journey.date, order: .reverse) private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.modelContext) private var context
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject private var addJourneyViewModel = AddJourneyViewModel()
    @StateObject private var trophiesViewModel = TrophiesViewModel()
    @StateObject private var carbonOutputViewModel = CarbonOutputViewModel()
    @State private var displayJourneySheet = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                PageHeaderView(pageTitle: "Journeys") {
                    NavigationLink {
                        LevelView()
                    } label: {
                        LevelIndicatorView(displayOuter: false, frameWidth: 32, progressWidth: 4, fontSize: 17)
                    }
                }
                .frame(height: horizontalSizeClass == .compact ? 75 : 90)
                
                VStack {
                    
                    if !journeys.isEmpty {
                        JourneysListView(addJourneyViewModel: addJourneyViewModel, journeys: journeys, context: context)
                    } else {
                        JourneyMessageView()
                    }
                    
                }
                .modifier(ConditionalPadding())
                .overlay(alignment: .bottom) {
                    
                    Button {
                        displayJourneySheet = true
                    } label: {
                        JourneysListAddButtonView()
                    }
                    .padding(.bottom)
                    .modifier(ConditionalPadding())
                    
                }
                
            }
            .popover(isPresented: $displayJourneySheet, attachmentAnchor: .point(.bottom),arrowEdge: .top) {
                AddJourneyForm(displayJourneySheet: $displayJourneySheet)
            }
        }
    }
}

#Preview {
    JourneysView()
}
