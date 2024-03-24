//
//  contactManager.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 21.03.24.
//

import Foundation
import Contacts

class ContactManager {
    static let shared = ContactManager()

    func getContactList(completion: @escaping ([CNContact]) -> Void) {
        let CNStore = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactIdentifierKey] as [CNKeyDescriptor]
                    let request = CNContactFetchRequest(keysToFetch: keys)
                    var tempContacts: [CNContact] = []
                    try CNStore.enumerateContacts(with: request) { contact, stop in
                        tempContacts.append(contact)
                    }
                    DispatchQueue.main.async {
                        completion(tempContacts)
                    }
                } catch {
                    print("Error on contact fetching \(error)")
                }
            }
        case .notDetermined:
            CNStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContactList(completion: completion)
                } else if let error = error {
                    print("Error requesting contact access: \(error)")
                } else {
                    print("Access denied")
                }
            }
        case .restricted, .denied:
            print("Access restricted or denied")
            completion([])

        @unknown default:
            print("Unknown authorization status")
            completion([])
        }
    }
}

