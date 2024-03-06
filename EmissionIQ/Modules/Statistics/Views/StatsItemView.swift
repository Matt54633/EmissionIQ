//
//  StatsItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display each indiviual stat with a title
struct StatsItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let statistic: String
    let title: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            VStack {
                
                Text(statistic)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(title)
                .font(.subheadline)
                
            }
            .padding(EdgeInsets(top: 12, leading: 5, bottom: 12, trailing: 5))
            
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    StatsItemView(statistic: "20", title: "Total Carbon")
}
