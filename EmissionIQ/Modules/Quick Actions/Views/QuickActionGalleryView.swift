//
//  QuickActionGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// Parent view for quick actions
struct QuickActionGalleryView: View {
    @Binding var displayJourneySheet: Bool
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            
            GalleryHeaderView(image: "ellipsis.circle.fill", title: "Quick Actions", displayNavIndicator: false, topPadding: 15)
            
            HStack {
                
                Button {
                    displayJourneySheet = true
                } label: {
                    QuickActionView(image: "plus.circle.fill", title: "Add Journey")
                }
                
                Button {
                    selectedTab = 1
                } label: {
                    QuickActionView(image: "map.circle.fill", title: "Journeys")
                }
                
            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    QuickActionGalleryView(displayJourneySheet: .constant(true), selectedTab: .constant(0))
}

