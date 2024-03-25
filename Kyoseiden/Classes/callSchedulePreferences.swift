//
//  callSchedulePreferences.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 24.03.24.
//

import Foundation
import SwiftData

// Define a class to store user schedule preferences
@Model
final class UserSchedulePreferences {
    // Properties to store the schedule preferences
    var callFrequency: CallFrequency
    var selectedDays: [DayOfWeek]
    var startTime: Date
    var endTime: Date

    init(callFrequency: CallFrequency = .daily,
         selectedDays: [DayOfWeek] = [],
         startTime: Date = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date(),
         endTime: Date = Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date()) {
        self.callFrequency = callFrequency
        self.selectedDays = selectedDays
        self.startTime = startTime
        self.endTime = endTime
    }

    // Function to save the user schedule preferences
    func save() {
        // Save logic here
        // This could involve storing data in a database or user defaults
    }
}
