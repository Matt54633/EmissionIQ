//
//  EmissionsProfileGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to display the link to the emissions profile
struct EmissionsProfileGalleryView: View {
    @Query private var journeys: [Journey]
    @StateObject var viewModel = EmissionsProfileViewModel()
    
    var body: some View {
        VStack {
            
            NavigationLink {
                EmissionsProfileView()
            } label: {
                VStack {
                    GalleryHeaderView(image: "person.crop.circle.fill", title: "Emissions Profile", displayNavIndicator: true, topPadding: 15)
                    
                    HStack {
                        
                        EmissionsProfileItemView(value: String(format: "%.0f", journeys.calculateTotalEmissions()), unit: "kg", image: "carbon.dioxide.cloud.fill")
                        
                        EmissionsProfileItemView(value: String(format: "%.0f", viewModel.emissionPercentagesByVehicleType[viewModel.allTransportTypes[viewModel.allTransportTypes.count / 2]]?.rounded(.up) ?? 0), unit: "%", image: viewModel.imageName(for: viewModel.allTransportTypes[viewModel.allTransportTypes.count / 2]))
                        
                    }
                    .padding(.horizontal)
                    
                }
            }
            .tint(.primary)
            
        }
        .onAppear {
            viewModel.calculateEmissions(journeys: journeys)
        }
    }
}

#Preview {
    EmissionsProfileGalleryView()
}
