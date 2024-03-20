//
//  UserPreferences.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation
import SwiftData

@Model
final class userPreferences {
    var userSelectedContacts: [userSelectedContacts]
    var availableDays: [Int] // 0 for Sunday, 1 for Monday, etc.
    var startTime: Date // Store only the time component
    var endTime: Date // Store only the time component
    var callFrequency: TimeInterval // In seconds, for simplicity

    init(userSelectedContacts: [userSelectedContacts], availableDays: [Int], startTime: Date, endTime: Date, callFrequency: TimeInterval) {
        self.userSelectedContacts = userSelectedContacts
        self.availableDays = availableDays
        self.startTime = startTime
        self.endTime = endTime
        self.callFrequency = callFrequency
    }
}
