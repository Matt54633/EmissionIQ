//
//  ImpactGalleryView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI
import SwiftData

// View to gamify and display the users' output, comparing it to the number of trees needed to offset etc.
struct ImpactGalleryView: View {
    @Query private var journeys: [Journey]
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @StateObject var viewModel = ImpactViewModel()
    
    var body: some View {
        NavigationLink {
            ImpactListView()
        } label: {
            
            VStack(alignment: .leading) {
                
                GalleryHeaderView(image: "carbon.dioxide.cloud.fill", title: "Impact", displayNavIndicator: true, topPadding: horizontalSizeClass == .compact ? 0 : 10)
                    .modifier(ConditionalPadding())
                
                let impactItemsView = ForEach(viewModel.itemTypes.indices, id: \.self) { index in
                    ImpactListItemView(viewModel: viewModel, itemType: viewModel.itemTypes[index], journeys: journeys)
                        .modifier(ConditionalContainerRelativeFrame(fixedWidth: 320))
                        .tint(.primary)
                }
                
                if horizontalSizeClass == .compact {
                    ScrollView(.horizontal) {
                        
                        LazyHStack {
                            impactItemsView
                        }
                        .scrollTargetLayout()
                        .frame(height: 50)
                        
                    }
                    .modifier(ConditionalContentMargins())
                    .modifier(ConditionalScrollTargetBehavior(behavior: .viewAligned))
                    
                } else {
                    ScrollView(.horizontal) {
                        
                        LazyHStack {
                            impactItemsView
                        }
                        .scrollTargetLayout()
                        .frame(height: 50)
                        
                    }
                    .modifier(ConditionalPadding())
                    .padding(.horizontal)
                }
            }
        }
        .tint(.primary)
    }
}

#Preview {
    ImpactGalleryView()
}
