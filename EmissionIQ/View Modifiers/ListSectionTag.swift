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
        content
            .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
            .font(.headline)
            .fontWeight(.semibold)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(.primaryGreen.opacity(colorScheme == .dark ? 0.25 : 0.125))
            )
            .padding(.vertical, 10)
            .foregroundStyle(.primaryGreen)
            .listRowInsets(EdgeInsets())
            .textCase(nil)
    }
}
