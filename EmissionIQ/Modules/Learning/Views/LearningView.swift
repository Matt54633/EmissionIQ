//
//  LearningView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 19/03/2024.
//

import SwiftUI
import SwiftData

// Display the links to different learning resources
struct LearningView: View {
    @Query private var readArticles: [ReadArticle]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                
                PageHeaderView(pageTitle: "Learning") {
                    NavigationLink {
                        LevelView()
                    } label: {
                        LevelIndicatorView(displayOuter: false, frameWidth: 32, progressWidth: 4, fontSize: 17)
                    }
                }
                .frame(height: horizontalSizeClass == .compact ? 75 : 90)
                
                ScrollView {
                    
                    Group {
                        
                        FactGalleryView()
                        
                        EmissionsProfileGalleryView()
                            .modifier(ConditionalPadding())
                        
                        ArticlesGalleryView(articleType: "topPicks")
                        
                        ArticlesGalleryView(articleType: "news")
                        
                        SourcesGalleryView()
                        
                        UserGuideGalleryView()
                            .padding(.bottom, 10)
                        
                    }
                    .padding(.bottom, 5)
                    
                }
                .padding(.top, horizontalSizeClass == .compact ? 15 : 30)
            }
        }
    }
}

#Preview {
    LearningView()
}
