//
//  getContactImage.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 22.03.24.
//

import Foundation
import SwiftUI
import Contacts

func getContactImage(contactId: String) -> Image? {
    let store = CNContactStore()
    let keys = [CNContactImageDataKey]
    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

    var contactImage: Image?

    do {
        try store.enumerateContacts(with: request) { contact, stop in
            if contact.identifier == contactId, let imageData = contact.imageData {
                if let uiImage = UIImage(data: imageData) {
                    contactImage = Image(uiImage: uiImage)
                    stop.pointee = true // Stop enumeration once the contact is found
                }
            }
        }
    } catch {
        print("Error fetching contact image: \(error)")
    }

    return contactImage
}
