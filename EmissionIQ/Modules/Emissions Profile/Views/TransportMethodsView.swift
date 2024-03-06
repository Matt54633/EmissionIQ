//
//  TransportMethodsView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display the emissions profile for each transport type
struct TransportMethodsView: View {
    @Query private var journeys: [Journey]
    @StateObject var viewModel = EmissionsProfileViewModel()
    
    private let tip = TransportTip()
    
    var body: some View {
        VStack {
            
            HStack {
                ForEach(viewModel.allTransportTypes.prefix(2), id: \.self) { transportType in
                    TransportMethodView(transportType: transportType, emissionPercentage: viewModel.emissionPercentagesByVehicleType[transportType]?.rounded(.up) ?? 0.0, emissionKg: Float(viewModel.emissionKgByVehicleType[transportType] ?? 0.0))
                }
            }
            
            HStack {
                ForEach(viewModel.allTransportTypes[2...4], id: \.self) { transportType in
                    TransportMethodView(transportType: transportType, emissionPercentage: viewModel.emissionPercentagesByVehicleType[transportType]?.rounded(.up) ?? 0.0, emissionKg: Float(viewModel.emissionKgByVehicleType[transportType] ?? 0.0))
                }
            }
            
            HStack {
                ForEach(viewModel.allTransportTypes[5...6], id: \.self) { transportType in
                    TransportMethodView(transportType: transportType, emissionPercentage: viewModel.emissionPercentagesByVehicleType[transportType]?.rounded(.up) ?? 0.0, emissionKg: Float(viewModel.emissionKgByVehicleType[transportType] ?? 0.0))
                }
            }
            
        }
        .fontWeight(.semibold)
        .popoverTip(tip, arrowEdge: .top)
        .onAppear {
            viewModel.calculateEmissions(journeys: journeys)
        }
        .onChange(of: journeys) {
            viewModel.calculateEmissions(journeys: journeys)
        }
    }
}

