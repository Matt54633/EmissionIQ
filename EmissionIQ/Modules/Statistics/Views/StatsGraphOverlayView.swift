//
//  StatsGraphOverlayView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display overlay on top of graphs with data insights
struct StatsGraphOverlayView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let chartType: String
    let date: Date
    let value: Float
    
    var body: some View {
        ZStack(alignment: .center) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            VStack(alignment: .leading) {
                
                Text(String(format: "%.1f", value))
                    .font(.title2.bold())
                     + Text(" \(chartType)").font(.caption)
                
                Text(date.longFormattedDate)
                    .font(.caption)
                
            }
            .padding(7.5)
            
        }
        .fixedSize(horizontal: true, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    StatsGraphOverlayView(chartType: "Journeys", date: Date(), value: 14)
}
