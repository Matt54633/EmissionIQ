//
//  QuickActionView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 14/03/2024.
//

import SwiftUI

// QuickActionView is a reusable view that can be used for a number of quick actions
struct QuickActionView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let image: String
    let title: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            VStack(alignment: .leading) {
                
                Image(systemName: image)
                    .font(.title2)
                    .foregroundStyle(.primaryGreen)
                
                Spacer()
                
                HStack {
                    Text(title)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                }
                
            }
            .fontWeight(.semibold)
            .padding(EdgeInsets(top: 10, leading: 12.5, bottom: 10, trailing: 12.5))
            
        }
        .fixedSize(horizontal: false, vertical: horizontalSizeClass == .regular ? true : false)
        .tint(.primary)
        
    }
}

#Preview {
    QuickActionView(image: "plus.circle.fill", title: "Add Journey")
}
