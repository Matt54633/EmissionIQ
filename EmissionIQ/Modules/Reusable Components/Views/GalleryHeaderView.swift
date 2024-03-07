//
//  GalleryHeaderView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import SwiftUI

// GalleryHeader is a reusable view to display the title, image and whether navigation is available
struct GalleryHeaderView: View {
    let image: String
    let title: String
    let displayNavIndicator: Bool
    let topPadding: CGFloat
    
    var body: some View {
        HStack(alignment: .center) {
            
            Image(systemName: image)
                .foregroundStyle(.primaryGreen)
                .frame(minWidth: 25)
            
            Text(title)
                .font(.title3)
            
            Spacer()
            
            if displayNavIndicator {
                Image(systemName: "chevron.right")
            }
            
        }
        .fontWeight(.semibold)
        .padding(EdgeInsets(top: topPadding, leading: 15, bottom: 5, trailing: 15))
    }
}
