//
//  SourceDetailsView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 08/03/2024.
//

import SwiftUI

// SourceDetailsView displays any paragraphs related to a source
struct SourceDetailsView: View {
    let source: Source
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ForEach(source.details.paragraphs, id: \.self) { paragraph in
                
                VStack(alignment: .leading) {
                    
                    Text(paragraph.header)
                        .fontWeight(.semibold)
                        .padding(.bottom, 2.5)
                    
                    Text(paragraph.text)
                        .padding(.bottom)
                    
                }
                
                Divider()
                    .padding(.bottom, 12.5)
            }
        }
    }
}

#Preview {
    SourceDetailsView(source: Source(name: "Conversion Factors", image: "function", details: Details(paragraphs: [Paragraph(header: "What are conversion factors?", text: "Conversion factors are...")], links: [SourceLink(header: "Source", url: "https://bbc.co.uk")])))
}
