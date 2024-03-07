//
//  ArticlesErrorView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to display in event articles cannot be fetched
struct ArticlesErrorView: View {
    var body: some View {
        ReusableErrorView(backgroundColour: .red, text: "Unable to retrieve Articles", textColor: .red, opacity: 0.2, radius: 25)
            .padding(.horizontal)
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ArticlesErrorView()
}
