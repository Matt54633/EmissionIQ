//
//  HomeView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display general information such a user's stats, carbon output and quick actions
struct HomeView: View {
    @Query(sort: \Journey.date, order: .reverse) private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var trophyViewModel = TrophiesViewModel()
    @State private var displayJourneySheet = false
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                CarbonOutputHeaderView()
                    .frame(height: horizontalSizeClass == .compact ? 150 : 175)
                
                VStack(alignment: .center) {
                    if !journeys.isEmpty {
                        
                        if geometry.size.height > 600 {
                            VStack {
                                ImpactGalleryView()
                                
                                Group {
                                    
                                    StatsGalleryView()
                                    
                                    TriviaGalleryView()
                                    
                                    if geometry.size.height > 750 {
                                        EmissionsProfileGalleryView()
                                    }
                                    
                                    QuickActionGalleryView(displayJourneySheet: $displayJourneySheet, selectedTab: $selectedTab)
                                    
                                }
                                .modifier(ConditionalPadding())
                                
                                Spacer()
                            }
                            .padding(.bottom)
                            
                        } else {
                            ScrollView {
                                ImpactGalleryView()
                                
                                Group {
                                    
                                    StatsGalleryView()
                                    
                                    TriviaGalleryView()
                                    
                                    QuickActionGalleryView(displayJourneySheet: $displayJourneySheet, selectedTab: $selectedTab)
                                    
                                }
                                .modifier(ConditionalPadding())
                            }
                        }
                        
                    } else {
                        JourneyMessageView()
                        
                        Button {
                            displayJourneySheet = true
                        } label: {
                            JourneyListAddButtonView()
                        }
                        
                    }
                    
                }
                
                Spacer()
                
            }
            .popover(isPresented: $displayJourneySheet, attachmentAnchor: .point(.bottom),arrowEdge: .top) {
                AddJourneyForm(displayJourneySheet: $displayJourneySheet)
            }
            .onChange(of: journeys) {
                trophyViewModel.updateAllTrophies(journeys: journeys, trophies: trophies, readArticles: readArticles)
            }
            
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(0))
}
