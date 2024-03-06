//
//  SourceLinksView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// SourceLinksView displays all the links for a given source
struct SourceLinksView: View {
    @Environment(\.colorScheme) var colorScheme
    let source: Source
    
    var body: some View {
        ForEach(source.details.links, id: \.self) { link in
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .dark ? .quaternary : .quinary)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Text(link.header)
                        
                        Spacer()
                        
                        Image(systemName: "globe")
                        
                    }
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                    
                    NavigationLink {
                        WebView(url: URL(string: link.url)!)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text(link.url)
                            .multilineTextAlignment(.leading)
                    }
                    
                }
                .padding()
            }
            .padding(.bottom, 10)
        }
    }
}

#Preview {
    SourceLinksView(source: Source(name: "Conversion Factors", image: "function", details: Details(paragraphs: [Paragraph(header: "What are conversion factors?", text: "Conversion factors are...")], links: [SourceLink(header: "Source", url: "https://bbc.co.uk")])))
}
