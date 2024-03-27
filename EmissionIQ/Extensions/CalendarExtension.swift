//
//  CalendarExtension.swift
//  EmissionIQ
//
//  Created by Matt Sullivan on 10/03/2024.
//

import Foundation
import SwiftUI

// Extend calendar to provide function to calculate number of days between 2 dates
extension Calendar {
    
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        
        return numberOfDays.day!
    }
    
}
