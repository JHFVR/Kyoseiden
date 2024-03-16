//
//  CreateMockContacts.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 15.03.24.
//

import Foundation
import Contacts

func createMockContacts() -> [Contact] {
    var contacts = [Contact]()

    let names = [("John", "Doe"), ("Jane", "Smith"), ("Emily", "Johnson"), ("Michael", "Brown"), ("Jessica", "Davis")]
    let phoneNumbers = ["1234567890", "0987654321", "5555555555", "6666666666", "7777777777"]

    for (index, name) in names.enumerated() {
        let contactId = UUID().uuidString // Generate a unique identifier
        let fullName = "\(name.0) \(name.1)"
        let phoneNumber = phoneNumbers[index]
        let lastCalled = Date().addingTimeInterval(-Double.random(in: 0...(5 * 24 * 60 * 60))) // Random lastCalled within the last 5 days

        let contact = Contact(contactId: contactId, name: fullName, phoneNumber: phoneNumber, lastCalled: lastCalled)
        contacts.append(contact)
    }

    return contacts
}

