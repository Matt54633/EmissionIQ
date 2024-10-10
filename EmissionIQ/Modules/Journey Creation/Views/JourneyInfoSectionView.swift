//
//  JourneyInfoSectionView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 02/03/2024.
//

import SwiftUI

// View to display information about different types of transportation methods
struct JourneyInfoSectionView: View {
    let title: String
    let images: [String]
    let description: String
    
    var body: some View {
        HStack {
            
            Text(title)
            
            Spacer()
            
            ForEach(images, id: \.self) { image in
                Image(systemName: image)
                    .foregroundStyle(.primaryGreen)
            }
            
        }
        .font(.headline)
        .fontWeight(.semibold)
        
        Text(description)
            .padding(.top, 1)
        
        Divider()
            .padding(.vertical)
        
    }
}

#Preview {
    JourneyInfoSectionView(title: "Cars", images: ["car.fill"], description: "Example text goes here")
}

