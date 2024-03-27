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
        VStack(alignment: .center) {
            
            Group {
                if let image = image {
                    Image(systemName: image)
                } else {
                    Text(value)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 55)
            .padding(.bottom, 2.5)
            
            Text(label)
                .font(.body)
                .fontWeight(.medium)
            
        }
        .font(.system(size: 32))
        .fontWeight(.semibold)
        
    }
}

#Preview {
    JourneyDetailView(image: "car", value: "Distance", label: "200")
}
