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
    
    internal init(contactId: String, firstName: String, lastName: String, lastCalled: Date? = nil) {
        self.contactId = contactId
        self.firstName = firstName
        self.lastName = lastName
        self.lastCalled = lastCalled
    }
    
    let contactId: String
    let firstName: String
    let lastName: String
    var lastCalled: Date?

    // this was so i can make a "hard copy" of all selected contacts and not just have a reference when searching i don't want to overwrite..
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = userSelectedContacts(contactId: self.contactId, firstName: self.firstName, lastName: self.lastName, lastCalled: self.lastCalled)
        return copy
    }
}


