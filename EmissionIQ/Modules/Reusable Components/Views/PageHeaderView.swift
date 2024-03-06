//
//  PageHeaderView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import SwiftUI

// PageHeaderView is used for page headers, using ViewBuilder to allow child elements to be passed in
struct PageHeaderView<Content: View>: View {
    let pageTitle: String
    let content: Content
    
    init(pageTitle: String, @ViewBuilder content: () -> Content) {
        self.pageTitle = pageTitle
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            WavyRectangle()
                .fill(.primaryGreen)
            
            HStack {
                
                Text(pageTitle)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                content
            }
            .modifier(ConditionalPadding())
            .padding(EdgeInsets(top: UIScreen.current?.bounds.height ?? 600 > 700 ? 55 : 30, leading: 15, bottom: 0, trailing: 15))
            
        }
        .ignoresSafeArea(.all)
    }
}
