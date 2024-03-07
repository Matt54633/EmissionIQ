//
//  FactGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// FactGalleryView displays new facts every hour about carbon emissions
struct FactGalleryView: View {
    @StateObject var viewModel = FactViewModel()
    
    var body: some View {
        VStack {
            
            GalleryHeaderView(image: "questionmark.diamond.fill", title: "Did You Know", displayNavIndicator: false, topPadding: 0)
            
            FactView(viewModel: viewModel)
                .onAppear {
                    viewModel.loadFact()
                }
            
        }
        .modifier(ConditionalPadding())
    }
}

#Preview {
    FactGalleryView()
}
