//
//  Contact.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import Foundation
import SwiftData

@Model
final class userSelectedContacts {
    
    internal init(contactId: String, firstName: String, lastName: String, phoneNumber: String, lastCalled: Date? = nil, _$backingData: any BackingData<userSelectedContacts> = userSelectedContacts.createBackingData()) {
        self.contactId = contactId
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.lastCalled = lastCalled
        self._$backingData = _$backingData
    }
    
    let contactId: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    var lastCalled: Date?

    
}


