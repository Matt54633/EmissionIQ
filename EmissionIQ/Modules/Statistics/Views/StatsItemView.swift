//
//  StatsItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 11/03/2024.
//

import SwiftUI

// View to display each indiviual stat with a title
struct StatsItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let statistic: String
    let title: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            VStack {
                
                Text(statistic)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(title)
                    .font(.caption)
                    .fontDesign(.rounded)
                
            }
            .padding(EdgeInsets(top: 12.5, leading: 2.5, bottom: 12.5, trailing: 2.5))
            
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    StatsItemView(statistic: "20", title: "Total Carbon")
}
