//
//  triggerBackgroundCall.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 25.03.24.
//

import Foundation

func scheduleCall() {
    let scheduler = CallScheduler.shared
    let callTime = Calendar.current.date(byAdding: .hour, value: 10, to: Date()) ?? Date()
    let phoneNumber = "+33616210172"

    scheduler.scheduleCall(at: callTime, to: phoneNumber)
}

// Call the function to schedule the call
//scheduleCall()
