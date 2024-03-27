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
            
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            HStack {
                
                Image(systemName: image)
                    .font(.title3)
                    .foregroundStyle(.primaryGreen)
                
                Spacer()
                
                Text(value)
                    .font(.title) + Text(unit).font(.caption)
                
            }
            .padding(.horizontal)
            
        }
        .fontWeight(.semibold)
        .frame(height: 60)
    }
}

#Preview {
    EmissionsProfileItemView(value: "25", unit: "kg", image: "carbon.dioxide.cloud")
}
