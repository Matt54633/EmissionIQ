//
//  QuickActionGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 14/03/2024.
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
                    QuickActionView(title: "Add Journey")
                }
                
                Button {
                    selectedTab = 1
                } label: {
                    QuickActionView(title: "All Journeys")
                }
                
            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    QuickActionGalleryView(displayJourneySheet: .constant(true), selectedTab: .constant(0))
}

