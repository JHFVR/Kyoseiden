//
//  UserPreferences.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation
import SwiftData

@Model
final class schedulePreferences {
    var callFrequency: String
    var selectedDays: [String]
    var startTime: Date
    var endTime: Date

    init(callFrequency: String, selectedDays: [String], startTime: Date, endTime: Date) {
        self.callFrequency = callFrequency
        self.selectedDays = selectedDays
        self.startTime = startTime
        self.endTime = endTime
    }

    init() {
        // Set default initial values here
        self.callFrequency = "daily"
        self.selectedDays = []
        self.startTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date()) ?? Date()
        self.endTime = Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: Date()) ?? Date()
    }
}
