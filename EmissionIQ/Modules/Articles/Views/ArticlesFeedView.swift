//
//  ArticlesFeedView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display Articles in a vertical scrolling feed
struct ArticlesFeedView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @ObservedObject var viewModel: ArticlesGalleryViewModel
    
    let pageTitle: String
    let articles: [Article]
    
    
    
    var body: some View {
        VStack {
            if !articles.isEmpty {
                
                ScrollView {
                    let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: horizontalSizeClass == .regular ? 2 : 1)
                    
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(articles, id: \.url) { article in
                            ArticleListItemView(article: article)
                        }
                    }
                    .padding()
                    .modifier(ConditionalPadding())
                    
                }
            } else {
                ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve Articles", textColor: .red, opacity: 0.2, radius: 25)
                    .padding(.horizontal)
            }
        }
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.large)
    }
}
