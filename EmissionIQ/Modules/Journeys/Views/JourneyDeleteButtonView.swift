//
//  JourneyDeleteButtonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display a bin image that a user can delete a journey with
struct JourneyDeleteButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddJourneyViewModel()
    @State private var showingConfirmation = false
    
    let journey: Journey
    
    var body: some View {
        Button {
            showingConfirmation = true
        } label: {
            Image(systemName: "trash")
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        .alert(isPresented: $showingConfirmation) {
            
            Alert(title: Text("Delete Journey"), message: Text("Are you sure you want to delete this journey?"), primaryButton: .destructive(Text("Delete")) {
                viewModel.deleteJourney(journey: journey, context: context)
                dismiss()
            }, secondaryButton: .cancel())
            
        }
    }
}
