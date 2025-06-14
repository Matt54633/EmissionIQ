//
//  AddJourneyButtonView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 02/03/2024.
//

import SwiftUI

// View to create button for saving new journeys
struct AddJourneyButtonView: View {
    @Environment(\.modelContext) private var context
    @ObservedObject var viewModel: AddJourneyViewModel
    @State private var isSavingJourney: Bool = false
    @Binding var vehicleType: String
    @Binding var manualDistance: String
    @Binding var journeyDate: Date
    @Binding var journeyReturn: Bool
    @Binding var showAlert: Bool
    @Binding var alertMessage: String?
    @Binding var displayJourneySheet: Bool
    @Binding var showManualDistance: Bool
    
    var body: some View {
        Button(action: {
            Task {
                do {
                    isSavingJourney = true
                    
                    let (shouldDisplayJourneySheet, message, shouldShowManualDistance, newJourney) = try await viewModel.saveJourney(transportType: vehicleType, manualDistance: manualDistance, journeyDate: journeyDate, journeyReturn: journeyReturn)
                    if let newJourney = newJourney {
                        viewModel.insertJourney(journey: newJourney, context: context)
                    }
                    displayJourneySheet = shouldDisplayJourneySheet
                    alertMessage = message
                    showAlert = message != nil
                    showManualDistance = shouldShowManualDistance
                    isSavingJourney = false
                } catch {
                    print("Error saving journey: \(error)")
                    isSavingJourney = false
                }
            }
        }) {
            ReusableButtonView(backgroundColour: .primaryGreen, text: "Save", textColor: .white, opacity: 1.0, radius: 15, disabled: viewModel.startLocation == nil || viewModel.endLocation == nil || isSavingJourney)
        }
        .padding(.bottom)
        .disabled(viewModel.startLocation == nil || viewModel.endLocation == nil || isSavingJourney)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Directions Unavailable!"), message: Text(alertMessage ?? ""), dismissButton: .default(Text("OK")))
        }
    }
}
