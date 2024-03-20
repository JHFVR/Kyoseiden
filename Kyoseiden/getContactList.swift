//
//  getContactList.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 17.03.24.
//

import Foundation
//import Contacts
//
//func getContactList() -> [CNContact] {
//    var contacts = [CNContact]()
//    let CNStore = CNContactStore()
//    switch CNContactStore.authorizationStatus(for: .contacts) {
//    case .authorized:
//        do {
//            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactIdentifierKey] as [CNKeyDescriptor]
//            let request = CNContactFetchRequest(keysToFetch: keys)
//            try CNStore.enumerateContacts(with: request) { contact, _ in
//                contacts.append(contact)
//            }
//        } catch {
//            print("Error on contact fetching \(error)")
//        }
//    case .denied, .notDetermined, .restricted:
//        print("Access denied or not determined")
//    @unknown default:
//        print("Unknown authorization status")
//    }
//    return contacts
//}
