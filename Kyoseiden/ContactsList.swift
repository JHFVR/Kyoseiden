//
//  ContactsList.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import SwiftUI
import Contacts
import SwiftData

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
