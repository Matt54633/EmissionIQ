//
//  TransportMethodOverlayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to overlay data for a given transport method
struct TransportMethodOverlayView: View {
    @Query private var journeys: [Journey]
    @ObservedObject var viewModel: EmissionsProfileViewModel
    
    let transportType: String
    let emissionPercentage: Float
    let emissionKg: Float
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Text(transportType.capitalized)
                    .font(.title3)
                
                Spacer()
                
                Image(systemName: viewModel.imageName(for: transportType))
                    .foregroundStyle(.primaryGreen)
                
            }
            .fontWeight(.semibold)
            .padding(.bottom, 5)
            
            HStack {
                
                Text("\(Int(emissionPercentage))%")
                
                Spacer(minLength: 20)
                
                Text("\(String(format: "%.1f", emissionKg))kg")
                
            }
            .font(.title)
            .padding(.bottom, 5)
            
            Text("^[\(journeys.filter { $0.method == transportType }.count) \("Journey")](inflect: true)")
            
        }
        .padding()
    }
}

#Preview {
    TransportMethodOverlayView(viewModel: EmissionsProfileViewModel(), transportType: "car", emissionPercentage: 34.3, emissionKg: 12.4)
}
