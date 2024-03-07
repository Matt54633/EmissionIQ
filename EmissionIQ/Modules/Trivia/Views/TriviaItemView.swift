//
//  TriviaItemView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// TriviaItemView displays a peelable trivia card
struct TriviaItemView: View {
    @ObservedObject var viewModel: TriviaViewModel
    
    var body: some View {
        VStack {
            if let trivia = viewModel.dailyTrivia {
                
                PeelEffectView(content: {
                    TriviaDetailView(title: trivia.question, type: "front")
                }, back: {
                    TriviaDetailView(title: trivia.answer, type: "back")
                })
                .frame(height: 80)
                
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    TriviaItemView(viewModel: TriviaViewModel())
}
