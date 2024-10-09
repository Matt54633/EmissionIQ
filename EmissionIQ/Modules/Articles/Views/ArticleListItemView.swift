//
//  ArticleListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 10/03/2024.
//

import SwiftUI
import SwiftData

// View to display Article previews in a scrolling list
struct ArticleListItemView: View {
    @Query private var journeys: [Journey]
    @Query private var trophies: [Trophy]
    @Query private var readArticles: [ReadArticle]
    @Environment(\.modelContext) private var context
    @StateObject var viewModel = ArticlesViewModel()
    @StateObject var trophiesViewModel = TrophiesViewModel()
    
    let article: Article
    
    var body: some View {
        NavigationLink {
            WebView(url: URL(string: article.url)!)
                .onAppear {
                    if !readArticles.contains(where: { $0.articleTitle == article.title }) {
                        context.insert(ReadArticle(articleTitle: article.title, dateRead: Date()))
                    }
                }
        } label: {
            ZStack {
                
                GlassEffectView(image: "newspapers", cornerRadius: 15)
                
                VStack(alignment: .leading) {
                    HStack {
                        
                        Image(systemName: "globe")
                            .font(.subheadline)
                        
                        Text(article.source.name)
                            .font(.subheadline)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.subheadline)
                    }
                    .fontWeight(.semibold)
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 6, trailing: 20))
                    
                    ZStack(alignment: .leading) {
                        
                        UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 15, bottomTrailingRadius: 15, topTrailingRadius: 0)
                            .fill(.ultraThinMaterial)
                            .colorScheme(.dark)
                        
                        Text(article.title)
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                }
            }
            .foregroundStyle(.white)
            .frame(height: 115)
        }
        .tint(.primary)
        .onChange(of: readArticles) {
            Task {
                await viewModel.setUserReadArticles(readArticles: readArticles.count)
            }
            
            trophiesViewModel.updateTrophies(trophies: trophies, journeys: journeys, readArticles: readArticles, context: context)
        }
    }
}

#Preview {
    ArticleListItemView(article: Article(
        source: ArticleSource(name: "BBC News"),
        title: "Climate Change: A Major Concern - Investigating how this crisis is affecting our planet",
        url: "https://www.bbc.com/news/"
    ))
}
