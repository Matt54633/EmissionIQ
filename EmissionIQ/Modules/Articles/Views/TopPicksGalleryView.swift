//
//  TopPicksGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display top picks in a scrolling list
struct TopPicksGalleryView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = ArticlesGalleryViewModel()
    
    var body: some View {
        VStack {
            
            NavigationLink {
                ArticlesFeedView(viewModel: viewModel, pageTitle: "Top Picks", articles: viewModel.topPicks)
            } label: {
                GalleryHeaderView(image: "lightbulb.max.fill", title: "Top Picks", displayNavIndicator: true, topPadding: 15)
                    .modifier(ConditionalPadding())
            }
            .tint(.primary)
            
            Group {
                
                if viewModel.articleError != nil {
                    
                    ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve Articles", textColor: .red, opacity: 0.2, radius: 25)
                        .padding(.horizontal)
                    
                } else if viewModel.topPicks.isEmpty {
                    
                    LoadingView()
                        .frame(height: 150)
                    
                } else {
                    
                    let topPicksView = ForEach(viewModel.topPicks, id: \.url) { article in
                        ArticleListItemView(article: article)
                            .modifier(ConditionalContainerRelativeFrame(fixedWidth: 350))
                    }
                    
                    if horizontalSizeClass == .compact {
                        
                        ScrollView(.horizontal) {
                            
                            LazyHStack {
                                topPicksView
                            }
                            .scrollTargetLayout()
                            
                        }
                        .modifier(ConditionalScrollTargetBehavior(behavior: .viewAligned))
                        .modifier(ConditionalContentMargins())
                    } else {
                        
                        ScrollView(.horizontal) {
                            
                            LazyHStack {
                                topPicksView
                            }
                            .scrollTargetLayout()
                            
                        }
                        .modifier(ConditionalPadding())
                        .padding(.horizontal)
                        
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchTopPicks()
        }
    }
}

#Preview {
    TopPicksGalleryView()
}

