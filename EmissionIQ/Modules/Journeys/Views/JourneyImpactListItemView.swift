//
//  JourneyImpactListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import SwiftUI

// JourneyImpactListItemView displays the impact of a specific journey on either distance travelled, total emissions or emissions by the transport mode
struct JourneyImpactListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = JourneyImpactViewModel()
    
    let impactType: String
    let journey: Journey
    let allJourneys: [Journey]
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            if let impactData = viewModel.impactData {
                HStack {
                    
                    Image(systemName: impactData.imageName)
                        .foregroundStyle(.primaryGreen)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        
                        Text(impactData.text)
                        
                        Text(impactType.capitalized)
                            .font(.caption)
                        
                    }
                    
                }
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
            }
        }
        .frame(height: 50)
        .padding(.vertical, 2.5)
        .onAppear {
            viewModel.fetchJourneyImpact(impactType: impactType, journey: journey, allJourneys: allJourneys)
        }
    }
}
