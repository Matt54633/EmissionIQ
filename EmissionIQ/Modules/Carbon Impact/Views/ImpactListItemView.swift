//
//  ImpactListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 07/03/2024.
//

import SwiftUI

// View to display comparison of carbon impact to certain items
struct ImpactListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: ImpactViewModel
    
    let itemType: String
    let journeys: [Journey]
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
                .frame(height: 50)
            
            HStack {
                Image(systemName: viewModel.setListItemValues(itemType: itemType, journeys: journeys).image)
                    .foregroundStyle(viewModel.setListItemValues(itemType: itemType, journeys: journeys).color)
                
                Spacer()
                
                viewModel.setListItemValues(itemType: itemType, journeys: journeys).text
                    .font(.subheadline)
            }
            .fontWeight(.semibold)
            .padding()
            
        }
    }
}
