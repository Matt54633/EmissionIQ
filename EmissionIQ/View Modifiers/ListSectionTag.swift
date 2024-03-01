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
                .foregroundStyle(.primaryGreen)
            content
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
        .padding(EdgeInsets(top: 7.5, leading: 15, bottom: 7.5, trailing: 15))
        .font(.system(size: 16))
        .fontWeight(.semibold)
        .background(
            Capsule()
                .fill(colorScheme == .dark ? Color(.tertiarySystemBackground).opacity(0.75) : Color(.secondarySystemBackground))
        )
        .padding(.vertical, 10)
        .listRowInsets(EdgeInsets())
        .textCase(nil)
    }
}
