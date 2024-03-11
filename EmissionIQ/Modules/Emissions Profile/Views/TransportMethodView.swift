//
//  TransportMethodView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 26/03/2024.
//

import SwiftUI

// View to display the emission percentage for a given transport type
struct TransportMethodView: View {
    @StateObject var viewModel = EmissionsProfileViewModel()
    @State private var displayOverlay: Bool = false
    
    var transportType: String
    var emissionPercentage: Float
    var emissionKg: Float
    
    var body: some View {
        ZStack {
            
            Circle()
                .frame(width: 90, height: 90)
                .foregroundColor(.primaryGreen.opacity(max(0.12, Double(emissionPercentage) / 100 + 0.11)))
            
            VStack {
                
                Image(systemName: viewModel.imageName(for: transportType))
                    .font(.title3)
                
                Text("\(Int(emissionPercentage))%")
                
            }
            .fontWeight(.semibold)
            
        }
        .onTapGesture {
            displayOverlay.toggle()
        }
        .popover(isPresented: $displayOverlay, attachmentAnchor: .point(.top), arrowEdge: .bottom) {
            TransportMethodOverlayView(viewModel: viewModel, transportType: transportType, emissionPercentage: emissionPercentage, emissionKg: emissionKg)
                .presentationCompactAdaptation(.popover)
        }
    }
}

#Preview {
    TransportMethodView(transportType: "car", emissionPercentage: 55, emissionKg: 40)
}
