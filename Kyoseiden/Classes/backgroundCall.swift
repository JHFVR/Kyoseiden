//
//  backgroundCall.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 25.03.24.
//

import Foundation
import UIKit
import CallKit

class CallScheduler: NSObject {
    static let shared = CallScheduler()

    private var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    private let callController = CXCallController()

    func scheduleCall(at time: Date, to phoneNumber: String) {
        // Calculate time until the scheduled call
        let timeInterval = time.timeIntervalSinceNow

        // Schedule a background task to make the call
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask {
            // Handle expiration of background task
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier ?? UIBackgroundTaskIdentifier.invalid)
            self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
        }

        // Perform the call after the specified time interval
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.makeCall(to: phoneNumber)
        }
    }

    private func makeCall(to phoneNumber: String) {
        // Configure call action
        let handle = CXHandle(type: .phoneNumber, value: phoneNumber)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)

        // Configure call transaction
        let transaction = CXTransaction(action: startCallAction)

        // Request call
        callController.request(transaction) { error in
            if let error = error {
                print("Error making call: \(error.localizedDescription)")
            } else {
                print("Call successfully initiated")
            }

            // End the background task
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier ?? UIBackgroundTaskIdentifier.invalid)
            self.backgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
        }
    }
}
