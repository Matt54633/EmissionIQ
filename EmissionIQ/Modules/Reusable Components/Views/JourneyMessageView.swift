//
//  JourneyMessageView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/03/2024.
//

import SwiftUI

// View to hide pages when a user has 0 journeys
struct JourneyMessageView: View {
    var body: some View {
            
        ContentUnavailableView {
            Label("Add a Journey to get Started!", systemImage: "point.topleft.down.to.point.bottomright.curvepath")
        }
        
    }
}

#Preview {
    JourneyMessageView()
}
