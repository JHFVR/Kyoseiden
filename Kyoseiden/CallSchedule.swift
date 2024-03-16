//
//  CallSchedule.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation
import SwiftData

@Model
final class CallSchedule {
    var scheduledCalls: [ScheduledCall]

    init(scheduledCalls: [ScheduledCall] = []) {
        self.scheduledCalls = scheduledCalls
    }

    func generateSchedule(userPreferences: UserPreferences) {
        // Implementation for generating call schedule based on user preferences
    }

    func updateSchedule() {
        // Implementation for updating the schedule, possibly after a call is made or preferences are changed
    }
}
