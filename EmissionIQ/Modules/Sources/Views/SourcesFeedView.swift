//
//  SourcesFeedView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display Sources in a vertical scrolling feed
struct SourcesFeedView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @ObservedObject var viewModel: SourcesViewModel
    
    let pageTitle: String
    let sources: [Source]
    
    var body: some View {
        VStack {
            if !sources.isEmpty {
                ScrollView {
                    
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: horizontalSizeClass == .regular ? 2 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(sources, id: \.name) { source in
                            SourcesListItemView(source: source)
                        }
                    }
                    .modifier(ConditionalPadding())
                    .padding()
                    
                }
            } else {
                ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve Sources", textColor: .red, opacity: 0.2, radius: 25)
                    .padding(.horizontal)
            }
        }
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}

