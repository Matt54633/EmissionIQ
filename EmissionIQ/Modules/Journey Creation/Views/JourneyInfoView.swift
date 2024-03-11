//
//  AddJourneyInfoView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 02/03/2024.
//

import SwiftUI

// View to display information about how journey distances and routes are calculated
struct JourneyInfoView: View {
    @Binding var displayInformationSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                
                Text("Journeys")
                    .padding(.vertical)
                
                Spacer()
                
                Button {
                    displayInformationSheet = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.gray)
                        .symbolRenderingMode(.hierarchical)
                }
                
            }
            .font(.title)
            .fontWeight(.bold)
            
            Divider()
                .padding(.bottom)
            
            JourneyInfoGridView()
            
        }
        .modifier(RoundedSheet(radius: 25, height: .large))
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
    }
}

#Preview {
    JourneyInfoView(displayInformationSheet: .constant(true))
}
