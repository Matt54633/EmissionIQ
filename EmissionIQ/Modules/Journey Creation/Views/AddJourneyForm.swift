//
//  AddJourneyForm.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI
import SwiftData

// View to display form for adding journeys
struct AddJourneyForm: View {
    @Environment(\.modelContext) private var context
    @StateObject private var viewModel = AddJourneyViewModel()
    @StateObject var networkManager = NetworkManager()
    @State private var vehicleType: String = "car"
    @State private var startLocation: String = "From"
    @State private var endLocation: String = "To"
    @State private var journeyDate: Date = Date()
    @State private var alertMessage: String?
    @State private var showAlert: Bool = false
    @State private var manualDistance: String = ""
    @State private var showManualDistance: Bool = false
    @State private var isReturn: Bool = false
    @State private var displayStartLocationSearchSheet: Bool = false
    @State private var displayEndLocationSearchSheet: Bool = false
    @State private var displayInformationSheet: Bool = false
    @Binding var displayJourneySheet: Bool
    
    var body: some View {
        VStack(alignment: .center) {
                        
            HStack {
                
                Text("\(vehicleType.capitalized) Journey")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack {
                    if !networkManager.isConnected {
                        NetworkConnectionView()
                    }
                    JourneyInfoButtonView(displayInformationSheet: $displayInformationSheet)
                }
                
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
            
            LocationPickerView(viewModel: viewModel, startLocation: $startLocation, endLocation: $endLocation, displayStartLocationSearchSheet: $displayStartLocationSearchSheet, displayEndLocationSearchSheet: $displayEndLocationSearchSheet, isReturn: $isReturn)
            
            TransportPickerView(vehicleType: $vehicleType)
            
            DatePickerView(journeyDate: $journeyDate)
            
            if showManualDistance {
                DistanceOverrideView(manualDistance: $manualDistance)
            }
            
            AddJourneyButtonView(viewModel: viewModel, vehicleType: $vehicleType, manualDistance: $manualDistance, journeyDate: $journeyDate, journeyReturn: $isReturn, showAlert: $showAlert, alertMessage: $alertMessage, displayJourneySheet: $displayJourneySheet, showManualDistance: $showManualDistance)
            
        }
        .modifier(RoundedSheet(radius: 25, height: .height(showManualDistance == true ? 410 : 350)))
        .padding([.top, .horizontal])
    }
}

#Preview {
    AddJourneyForm(displayJourneySheet: .constant(true))
}
