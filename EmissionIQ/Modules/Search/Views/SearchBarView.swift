//
//  SearchBarView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 06/03/2024.
//

import SwiftUI

// View to create a custom search bar
struct SearchBarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            
            TextField("", text: $searchText, prompt: Text("Search"))
                .font(.title3)
                .padding()
                .background(
                    Capsule()
                        .fill(colorScheme == .dark ? .quaternary : .quinary)
                        .frame(height: 60)
                )
                .overlay(alignment: .trailing) {
                    ZStack {
                        
                        Circle()
                            .fill(.primaryGreen.gradient)
                            .frame(height: 40)
                        
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                            .foregroundStyle(.white)
                        
                    }
                    .padding(.trailing, 10)
                }
        }
        .fontWeight(.semibold)
        .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 15))
    }
}
