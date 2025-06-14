//
//  ImpactListView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import SwiftUI
import SwiftData

// View to display the users total emissions alongside all impact views
struct ImpactListView: View {
    @Query private var journeys: [Journey]
    @StateObject private var viewModel = ImpactViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text("\((String(format: "%.1f", journeys.calculateTotalEmissions())))")
                        .font(.system(size: 70))
                    Text("kg CO₂e")
                        .font(.title2)
                }
                .fontWeight(.bold)
                .foregroundStyle(.primaryGreen)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("That's equivalent to:")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                    
                }
                .fontWeight(.semibold)
                
                ScrollView {
                    if !journeys.isEmpty {
                        
                        ForEach(viewModel.itemTypes, id: \.self) { item in
                            ImpactListItemView(viewModel: viewModel, itemType: item, journeys: journeys)
                        }
                        
                    } else {
                        JourneyMessageView()
                    }
                }
                .padding(.top, 5)
                
            }
            .navigationTitle("Impact")
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
            .modifier(ConditionalPadding())
        }
    }
}

#Preview {
    ImpactListView()
}
