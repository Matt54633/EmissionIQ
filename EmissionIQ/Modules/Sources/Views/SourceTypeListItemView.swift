//
//  SourceTypeListItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display a list item for a source type in a scrolling list
struct SourceTypeListItemView: View {
    @Environment(\.colorScheme) var colorScheme
    let source: Source
    
    var body: some View {
        NavigationLink {
            SourceView(source: source)
        } label: {
            ZStack {
                
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .dark ? .quaternary : .quinary)
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        
                        Image(systemName: source.image)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                    }
                    
                    Spacer()
                    
                    HStack {
                        
                        Text(source.name)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                        
                    }
                    .fontWeight(.semibold)
                }
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .padding()
            }
        }
        .frame(height: 110)
        .tint(.primary)
    }
}

#Preview {
    SourceTypeListItemView(source: Source(name: "Conversion Factors", image: "function", details: Details(paragraphs: [Paragraph(header: "What are conversion factors?", text: "Conversion factors are...")], links: [SourceLink(header: "Source", url: "https://bbc.co.uk")])))
}
