//
//  EmissionsProfileItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/03/2024.
//

import SwiftUI

// View to display an individual emissions profile item
struct EmissionsProfileItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let value: String
    let unit: String
    let image: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
.fill(.listItemBackground)            
            HStack {
                
                Image(systemName: image)
                    .font(.subheadline)
                    .foregroundStyle(.primaryGreen)
                
                Spacer()
                
                Text(value)
                    .font(.title3) + Text(unit).font(.caption)
                
            }
            .padding(.horizontal, 12.5)
            
        }
        .fontWeight(.bold)
        .frame(height: 45)
    }
}

#Preview {
    EmissionsProfileItemView(value: "25", unit: "kg", image: "carbon.dioxide.cloud")
}
