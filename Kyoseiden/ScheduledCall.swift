//
//  ScheduledCall.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation

class ScheduledCall {
    let contact: Contact
    var callTime: Date

    init(contact: Contact, callTime: Date) {
        self.contact = contact
        self.callTime = callTime
    }

    func makeCall() {
        // Implementation for making the call
        // Note: Actual call functionality would depend on iOS's CallKit and cannot be directly initiated from the app for privacy reasons.
    }

    func reschedule(newTime: Date) {
        self.callTime = newTime
    }
}
