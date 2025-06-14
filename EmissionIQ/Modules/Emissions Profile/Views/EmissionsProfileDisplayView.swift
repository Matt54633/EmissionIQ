//
//  EmissionsProfileDisplayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/03/2024.
//

import SwiftUI
import SwiftData

// View to display the various emissions profile views
struct EmissionsProfileDisplayView: View {
    @Query private var journeys: [Journey]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            if !journeys.isEmpty {
                
                if horizontalSizeClass == .compact {
                    Spacer()
                    
                    TransportMethodsView()
                    
                    Spacer()
                    
                    EmissionsProfileBreakdownView()
                } else {
                    HStack {
                        TransportMethodsView()
                        
                        EmissionsProfileBreakdownView()
                    }
                }
            } else {
                JourneyMessageView()
            }
            
        }
        .modifier(ConditionalPadding())
        .navigationTitle("Emissions Profile")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    EmissionsProfileDisplayView()
}
