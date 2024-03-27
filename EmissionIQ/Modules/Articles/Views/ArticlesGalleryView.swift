//
//  ArticlesGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 09/03/2024.
//

import SwiftUI

// View to display articles in a scrolling list
struct ArticlesGalleryView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = ArticlesViewModel()
    
    let articleType: String
    
    var articles: [Article] {
        return articleType == "news" ? viewModel.articles : viewModel.topPicks
    }
    
    var body: some View {
        VStack {
            
            NavigationLink {
                ArticlesFeedView(viewModel: viewModel, pageTitle: articleType == "news" ? "In the News" : "Top Picks", articles: articles)
            } label: {
                GalleryHeaderView(image: "newspaper.fill", title: articleType == "news" ? "In the News" : "Top Picks", displayNavIndicator: true, topPadding: 15)
                    .modifier(ConditionalPadding())
            }
            .tint(.primary)
            
            Group {
                
                if articleType == "news" && viewModel.articleError != nil {
                    
                    ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve news articles", textColor: .red, opacity: 0.2, radius: 25)
                        .padding(.horizontal)
                    
                } else if articleType == "topPicks" && viewModel.topPicksError != nil {
                    
                    ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve top picks", textColor: .red, opacity: 0.2, radius: 25)
                        .padding(.horizontal)
                    
                }  else if articles.isEmpty {
                    LoadingView()
                        .frame(height: 150)
                } else  {
                    
                    let articlesView = ForEach(articles, id: \.url) { article in
                        ArticleListItemView(article: article)
                            .modifier(ConditionalContainerRelativeFrame(fixedWidth: 350))
                    }
                    
                    if horizontalSizeClass == .compact {
                        
                        ScrollView(.horizontal) {
                            
                            LazyHStack {
                                articlesView
                            }
                            .scrollTargetLayout()
                            
                        }
                        .modifier(ConditionalScrollTargetBehavior(behavior: .viewAligned))
                        .modifier(ConditionalContentMargins())
                        
                    } else {
                        
                        ScrollView(.horizontal) {
                            
                            LazyHStack {
                                articlesView
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
            if articleType == "news" {
                viewModel.fetchClimateChangeNews()
            } else  {
                viewModel.fetchTopPicks()
            }
        }
    }
}

#Preview {
    ArticlesGalleryView(articleType: "news")
}

