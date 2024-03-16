//
//  Settings.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation
import SwiftData

@Model
final class Settings {
    var flashlightNotification: Bool
    var callReminder: Bool

    init(flashlightNotification: Bool = false, callReminder: Bool = false) {
        self.flashlightNotification = flashlightNotification
        self.callReminder = callReminder
    }

    func toggleSetting(setting: String) {
        // Toggle the specified setting
        switch setting {
        case "flashlightNotification":
            flashlightNotification.toggle()
        case "callReminder":
            callReminder.toggle()
        default:
            break
        }
    }
}
