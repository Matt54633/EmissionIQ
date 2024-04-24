//
//  UserGuideGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 14/03/2024.
//

import SwiftUI

// View to navigate to the user guide
struct UserGuideGalleryView: View {
    var body: some View {
        VStack {
            
            NavigationLink {
                PdfDisplayView()
            } label: {
                GalleryHeaderView(image: "doc.fill", title: "User Guide ", displayNavIndicator: true, topPadding: 0)
                    .modifier(ConditionalPadding())
            }
            .tint(.primary)
            
        }
    }
}

#Preview {
    UserGuideGalleryView()
}
