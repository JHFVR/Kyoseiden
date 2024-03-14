//
//  Contact.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation

class Contact {
    let contactId: String
    let name: String
    let phoneNumber: String
    var lastCalled: Date?

    init(contactId: String, name: String, phoneNumber: String, lastCalled: Date? = nil) {
        self.contactId = contactId
        self.name = name
        self.phoneNumber = phoneNumber
        self.lastCalled = lastCalled
    }
}
