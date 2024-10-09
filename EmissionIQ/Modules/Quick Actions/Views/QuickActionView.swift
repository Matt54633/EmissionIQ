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
    let title: String
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? .quaternary : .quinary)
            
            HStack {
                
                    Text(title)
                    .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                    .font(.subheadline)
                        .foregroundStyle(.gray)
                
                
            }
            .fontWeight(.semibold)
            .padding(EdgeInsets(top: 12.5, leading: 12.5, bottom: 12.5, trailing: 12.5))
            
        }
        .fixedSize(horizontal: false, vertical: horizontalSizeClass == .regular ? true : false)
        .tint(.primary)
        
    }
}

#Preview {
    QuickActionView(title: "Add Journey")
}
