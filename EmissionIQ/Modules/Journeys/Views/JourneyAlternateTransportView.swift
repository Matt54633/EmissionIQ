//
//  JourneyAlternateTransportView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 13/03/2024.
//

import SwiftUI

// View to display an alternate transport method if it saves emissions
struct JourneyAlternateTransportView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = JourneyImpactViewModel()
    
    let journey: Journey
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 15)
.fill(.listItemBackground)            
            if let alternateTransport = viewModel.alternateTransport {
                HStack {
                    
                    Image(systemName: alternateTransport.imageName)
                        .foregroundStyle(.primaryGreen)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(alternateTransport.text)
                            .font(.subheadline)
                    }
                    
                }
                .fontWeight(.semibold)
                .padding(.horizontal, 12)
                
            }
            
        }
        .frame(height: 50)
        .padding(.bottom, 5)
        .onAppear {
            viewModel.suggestAlternateTransport(journey: journey)
        }
    }
}
