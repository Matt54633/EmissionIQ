//
//  SourceView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 08/03/2024.
//

import SwiftUI

// View to display information and links to data sources
struct SourceView: View {
    let source: Source
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                
                SourceDetailsView(source: source)
                
                SourceLinksView(source: source)
                
                Spacer()
                
            }
            .padding()
            .navigationTitle(source.name)
            .navigationBarTitleDisplayMode(.large)
            .modifier(ConditionalPadding())
        }
    }
}

#Preview {
    SourceView(source: Source(name: "Conversion Factors", image: "function", details: Details(paragraphs: [Paragraph(header: "What are conversion factors?", text: "Conversion factors are...")], links: [SourceLink(header: "Source", url: "https://bbc.co.uk")])))
}
