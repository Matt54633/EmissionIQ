//
//  JourneyDetailView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// JourneyDetailView displays information about a single detail about a journey
struct JourneyDetailView: View {
    var image: String?
    var value: String
    var label: String
    
    var body: some View {
        VStack(alignment: .center) {
            
            if let image = image {
                Image(systemName: image)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 2.5)
            } else {
                Text(value)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 2.5)
            }
            
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
