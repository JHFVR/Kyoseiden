//
//  ContactsList.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import SwiftUI
import Contacts

func createMockContacts() -> [CNContact] {
    var contacts = [CNContact]()
    
    let contact1 = CNMutableContact()
    contact1.givenName = "John"
    contact1.familyName = "Doe"
    contact1.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: "1234567890"))]
    
    let contact2 = CNMutableContact()
    contact2.givenName = "Jane"
    contact2.familyName = "Smith"
    contact2.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: "0987654321"))]
    
    contacts.append(contentsOf: [contact1, contact2])
    
    return contacts
}

struct ContactsList: View {
    @State private var contacts: [CNContact] = []

    var body: some View {
        List(contacts, id: \.identifier) { contact in
            VStack(alignment: .leading) {
                Text(contact.givenName + " " + contact.familyName)
                ForEach(contact.phoneNumbers, id: \.identifier) { phoneNumber in
                    Text(phoneNumber.value.stringValue)
                }
            }
        }
        .onAppear {
            self.contacts = createMockContacts()
        }
    }
}

struct ContactsList_Previews: PreviewProvider {
    static var previews: some View {
        ContactsList()
    }
}
