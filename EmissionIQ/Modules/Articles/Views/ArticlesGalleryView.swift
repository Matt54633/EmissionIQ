//
//  ArticlesGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display articles in a scrolling list
struct ArticlesGalleryView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = ArticlesGalleryViewModel()
    
    var body: some View {
        VStack {
            
            NavigationLink {
                ArticlesFeedView(viewModel: viewModel, pageTitle: "In the News", articles: viewModel.articles)
            } label: {
                GalleryHeaderView(image: "newspaper.fill", title: "In the News", displayNavIndicator: true, topPadding: 15)
                    .modifier(ConditionalPadding())
            }
            .tint(.primary)
            
            Group {
                
                if viewModel.articleError != nil {
                    
                    ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve Articles", textColor: .red, opacity: 0.2, radius: 25)
                        .padding(.horizontal)
                    
                }  else if viewModel.articles.isEmpty {
                    LoadingView()
                        .frame(height: 150)
                } else  {
                    
                    let articlesView = ForEach(viewModel.articles, id: \.url) { article in
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
            viewModel.fetchClimateChangeNews()
        }
    }
}

#Preview {
    ArticlesGalleryView()
}

