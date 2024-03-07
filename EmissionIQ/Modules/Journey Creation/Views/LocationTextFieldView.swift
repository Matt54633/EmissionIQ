//
//  LocationTextFieldView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// LocationTextFieldView displays a text field used for adding locations
struct LocationTextFieldView: View {
    @ObservedObject var viewModel: AddJourneyViewModel
    @Binding var location: String
    @Binding var displayLocationSearchSheet: Bool
    
    let locationType: String
    let paddingDirection: Alignment
    let radiusValues: [CGFloat]
    
    var body: some View {
        
        Text(location)
            .modifier(LocationTextField(paddingDirection: paddingDirection, radiusValues: radiusValues))
            .onTapGesture {
                displayLocationSearchSheet = true
            }
            .sheet(isPresented: $displayLocationSearchSheet) {
                SearchDisplayView(addJourneyViewModel: viewModel, displaySearchSheet: $displayLocationSearchSheet, inputText: $location, locationType: locationType)
            }
        
    }
}
