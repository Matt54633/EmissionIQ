//
//  OnboardingDetailView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// OnboardingDetailView displays information about an onboarding view with a dashed rectangular border
struct OnboardingDetailView: View {
    let image: String
    let title: String
    let subTitle: String
    let systemImage: Bool
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.lightGrey.opacity(0.2))
            
            VStack {
                
                Group {
                    
                    if systemImage {
                        Image(systemName: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundStyle(.primaryGreen)
                    } else {
                        Image(image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primaryGreen)
                        .lineLimit(2)
                    
                    Text(subTitle)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(5)
                
            }
            .padding(25)
            
        }
        .padding(.vertical)
        
    }
}

#Preview {
    OnboardingDetailView(image: "location.circle.fill", title: "Location Access", subTitle: "We use your location to display localised search results.", systemImage: true)
}
