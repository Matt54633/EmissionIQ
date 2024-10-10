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
        
        HStack(spacing: 10) {
            Image(systemName: "calendar")
                .foregroundStyle(.primaryGreen)
            content
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        .font(.caption)
        .fontWeight(.semibold)
        .textCase(nil)
        .padding(EdgeInsets(top: 7.5, leading: 12.5, bottom: 7.5, trailing: 12.5))
        .background(
            Capsule()
                .fill(.listItemBackground)
        )
        .padding(.bottom, 10)
        .listRowInsets(EdgeInsets())
        
    }
}
