//
//  TriviaGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// TriviaGalleryView displays a daily trivia item that educates the user
struct TriviaGalleryView: View {
    @StateObject var viewModel = TriviaViewModel()
    private let tip = TriviaTip()
    
    var body: some View {
        GalleryHeaderView(image: "wand.and.rays", title: "Today's Trivia", displayNavIndicator: false, topPadding: 15)
        
        TriviaItemView(viewModel: viewModel)
            .popoverTip(tip, arrowEdge: .bottom)
            .onAppear {
                viewModel.loadTrivia()
            }
    }
}

#Preview {
    TriviaGalleryView()
}
