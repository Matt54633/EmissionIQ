//
//  SourcesGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display sources in a scrolling list
struct SourcesGalleryView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = SourcesViewModel()
    
    var body: some View {
        NavigationStack {
            
            NavigationLink {
                SourcesFeedView(viewModel: viewModel, pageTitle: "Sources", sources: viewModel.sources)
                
            } label: {
                GalleryHeaderView(image: "checkmark.seal.fill", title: "Sources", displayNavIndicator: true, topPadding: 15)
                    .modifier(ConditionalPadding())
            }
            .tint(.primary)
            
            if horizontalSizeClass == .compact {
                ScrollView(.horizontal) {
                    
                    LazyHStack {
                        ForEach(viewModel.sources, id: \.name) { source in
                            SourceTypeListItemView(source: source)
                                .modifier(ConditionalContainerRelativeFrame(fixedWidth: 225))
                        }
                    }
                    .scrollTargetLayout()
                    
                }
                .modifier(ConditionalScrollTargetBehavior(behavior: .viewAligned))
                .modifier(ConditionalContentMargins())
            } else {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 20) {
                    
                    ForEach(viewModel.sources, id: \.name) { source in
                        SourceTypeListItemView(source: source)
                    }
                    
                }
                .padding(.horizontal)
                .modifier(ConditionalPadding())
            }
        }
        .padding(.bottom)
        .onAppear {
            viewModel.loadSources()
        }
    }
}


#Preview {
    SourcesGalleryView()
}

