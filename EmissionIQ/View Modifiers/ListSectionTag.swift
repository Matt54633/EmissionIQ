//
//  ListSectionTag.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 25/02/2024.
//

import SwiftUI

// View modifier to style section headers of lists
struct ListSectionTag: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        
        HStack {
            Image(systemName: "calendar")
            content
        }
        .font(.headline)
        .fontWeight(.semibold)
        .foregroundStyle(.primaryGreen)
        .textCase(nil)
        .padding(EdgeInsets(top: 7.5, leading: 12.5, bottom: 7.5, trailing: 12.5))
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? .primaryGreen.opacity(0.25) : .primaryGreen.opacity(0.15))
        )
        .padding(.bottom, 12.5)
        .listRowInsets(EdgeInsets())
        
    }
}
