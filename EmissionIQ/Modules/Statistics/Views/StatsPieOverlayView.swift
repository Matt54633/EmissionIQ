//
//  StatsPieOverlayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 12/03/2024.
//

import SwiftUI

// View to display overlay on top of pie charts with data insights
struct StatsPieOverlayView: View {
    let title: String
    let subTitle: String
    let selectedMethod: String?
    let journeysByMethod: [String: (count: Int, totalCarbon: Float, totalDistance: Float)]
    let viewModel: StatsPieViewModel
    
    var body: some View {
        VStack {
            
            if selectedMethod == nil {
                
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(subTitle)
                    .foregroundStyle(.secondary)
                
            } else {
                
                Text(String(format: "%.0f" , viewModel.getValue(for: selectedMethod!, subTitle: subTitle, journeysByMethod: journeysByMethod)))
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(selectedMethod?.capitalized ?? "")
                    .foregroundStyle(.secondary)
                
            }
        }
    }
}
