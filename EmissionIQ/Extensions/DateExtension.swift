//
//  DateExtension.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 23/02/2024.
//

import Foundation

// Extension creates a readable format in different formats
extension Date {
    var firstDayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: self)
    }

    var longFormattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
    
    var endOfWeek: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)!.addingTimeInterval(6 * 24 * 60 * 60)
    }
}
