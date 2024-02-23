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
        ZStack(alignment: .leading) {
            WavyRectangle()
                .fill(.primaryGreen)
            
            HStack {
                Text(pageTitle)
                    .fontWeight(.semibold)
                    .font(.title)
                    .foregroundStyle(.white)
                
                Spacer()
                
                content
                
            }
            .padding()
            .padding(.top, 30)
        }
        .ignoresSafeArea(.all)
    }
}

