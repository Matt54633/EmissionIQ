//
//  JourneyDetailView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 05/03/2024.
//

import SwiftUI

// JourneyDetailView displays information about a single detail about a journey
struct JourneyDetailView: View {
    var image: String?
    var value: String
    var label: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            
            Group {
                if let image = image {
                    Image(systemName: image)
                } else {
                    Text(value)
                    
                }
            }
            .frame(height: 40)
            
            Text(label)
                .font(.body)
                .fontWeight(.medium)
            
        }
        .font(.system(size: 32))
        .fontWeight(.semibold)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(RoundedRectangle(cornerRadius: 15).fill(.listItemBackground))

        
    }
}

#Preview {
    JourneyDetailView(image: "car", value: "Distance", label: "200")
}
