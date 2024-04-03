//
//  DatePickerView.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 01/03/2024.
//

import SwiftUI

// View to display a date picker and title
struct DatePickerView: View {
    @Binding var journeyDate: Date
    
    var body: some View {
        
        DatePicker("Date", selection: $journeyDate, displayedComponents: .date)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
        
    }
}

#Preview {
    DatePickerView(journeyDate: .constant(Date()))
}
