//
//  TriviaDetailView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// TriviaDetailView displays one side of the trivia item, the question or answer
struct TriviaDetailView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let title: String
    let type: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20).fill(type == "back" ? .peelGreen : .primaryGreen)
                
                HStack {
                    if type == "back" {
                        Spacer()
                    }
                    
                    Text(title)
                        .font(horizontalSizeClass == .compact ? .subheadline : .headline)
                        .fontWeight(.medium)
                        .padding(.trailing, type == "back" ? (horizontalSizeClass == .regular ? geometry.size.width * 0.03 : geometry.size.width * 0.1) : 45)
                        .padding(.leading, type == "back" ? 50: 20)
                }
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    TriviaDetailView(title: "Question here?", type: "front")
}
