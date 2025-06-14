//
//  HomeView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 29/02/2024.
//

import SwiftUI
import SwiftData

// View to display general information such a user's stats, carbon output and quick actions
struct HomeView: View {
    @Query(sort: \Journey.date, order: .reverse) private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.modelContext) var context
    @StateObject var trophiesViewModel = TrophiesViewModel()
    @State private var displayJourneySheet = false
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                CarbonOutputHeaderView()
                    .frame(height: horizontalSizeClass == .compact ? 150 : 175)
                
                VStack(alignment: .center, spacing: 25) {
                    if !journeys.isEmpty {
                        
                        ScrollView {
                            VStack {
                                ImpactGalleryView()
                                
                                Group {
                                    
                                    StatsGalleryView()
                                    
                                    TriviaGalleryView()
                                    
                                    EmissionsProfileGalleryView()
                                    
                                    QuickActionGalleryView(displayJourneySheet: $displayJourneySheet, selectedTab: $selectedTab)
                                    
                                }
                                .modifier(ConditionalPadding())
                                
                            }
                            .padding(.bottom)
                        }
                        .padding(.top)
                        
                        
                    } else {
                        JourneyMessageView()
                        
                        Button {
                            displayJourneySheet = true
                        } label: {
                            JourneysListAddButtonView()
                        }
                        .padding(.bottom)
                    }
                    
                }
                
            }
            .popover(isPresented: $displayJourneySheet, attachmentAnchor: .point(.bottom),arrowEdge: .top) {
                AddJourneyForm(displayJourneySheet: $displayJourneySheet)
            }
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
}
