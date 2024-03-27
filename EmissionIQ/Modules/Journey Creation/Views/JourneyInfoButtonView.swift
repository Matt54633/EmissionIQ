//
//  JourneyInfoButtonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 02/03/2024.
//

import SwiftUI

// View to create button for showing information about journey calculations
struct JourneyInfoButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var displayInformationSheet: Bool
    
    var body: some View {
        Button {
            displayInformationSheet = true
        } label: {
            Image(systemName: "info.circle.fill")
                .font(.title)
                .foregroundStyle(colorScheme == .dark ? .white : .gray)
                .symbolRenderingMode(.hierarchical)
        }
        .popover(isPresented: $displayInformationSheet) {
            JourneyInfoView(displayInformationSheet: $displayInformationSheet)
        }
    }
}

#Preview {
    JourneyInfoButtonView(displayInformationSheet: .constant(true))
}
