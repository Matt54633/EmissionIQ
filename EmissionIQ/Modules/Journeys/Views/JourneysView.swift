//
//  JourneysView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
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
    @State private var displayJourneySheet = false
    @StateObject private var addJourneyViewModel = AddJourneyViewModel()
    @StateObject private var trophyViewModel = TrophiesViewModel()
    @StateObject private var carbonOutputViewModel = CarbonOutputViewModel()
    
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
                .frame(height: horizontalSizeClass == .compact ? 75 : 110)
                
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
            .onChange(of: journeys) {
                if !journeys.isEmpty {
                    if trophies.isEmpty {
                        trophyViewModel.initialiseTrophies(trophies: trophies, context: context)
                    }
                    trophyViewModel.removeDuplicateTrophies(trophies: trophies, context: context)
                    trophyViewModel.updateAllTrophies(journeys: journeys, trophies: trophies, readArticles: readArticles)
                }
                
                Task {
                    await carbonOutputViewModel.setUserAttributes(journeys: journeys, trophies: trophies, readArticles: readArticles)
                }
            }
        }
    }
}

#Preview {
    JourneysView()
}
