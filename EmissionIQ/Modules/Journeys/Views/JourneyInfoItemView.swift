//
//  JourneyInfoItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import SwiftUI

// View to display information for a journey, e.g. date
struct JourneyInfoItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let image: String
    let text: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            HStack {
                
                Image(systemName: image)
                    .foregroundStyle(.primaryGreen)
                
                Spacer()
                
                Text(text)
                
            }
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            
        }
        .frame(height: 50)
        .padding(.bottom, 5)
    }
}

#Preview {
    JourneyInfoItemView(image: "calendar", text: "27/07/29")
}
