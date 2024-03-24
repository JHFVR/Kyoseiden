//
//  editFriendList.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 18.03.24.
//

import SwiftUI
import Contacts
import SwiftData

struct editFriendList: View {
    @State private var contacts = [CNContact]()
    @State private var searchText = ""
    @State private var selectedContacts: Set<String> = [] // Using contact identifier as the key
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    // i am running the copy of user data later on.appear.. so all initializes properly before
    @Query private var userSelectedContacts: [userSelectedContacts]
    @State private var copySelectedNotYetSaved: [userSelectedContacts] = []
    @State private var selectedNotYetSaved: [userSelectedContacts] = []
    
//    // Added initializer to accept contacts
//    init(contacts: [CNContact] = []) {
//        _contacts = State(initialValue: contacts)
//    }
    
    var filteredContacts: [CNContact] {
        let selectedIdentifiers = Set(selectedNotYetSaved.map { $0.contactId })
        
        // first see if search txt has selected contactsw
        let selected = contacts.filter { selectedIdentifiers.contains($0.identifier) }
            .filter { contact in
                searchText.isEmpty ||
                contact.givenName.localizedCaseInsensitiveContains(searchText) ||
                contact.familyName.localizedCaseInsensitiveContains(searchText)
            }

        // then rest...
        let remaining = contacts.filter { !selectedIdentifiers.contains($0.identifier) }
            .filter { contact in
                searchText.isEmpty ||
                contact.givenName.localizedCaseInsensitiveContains(searchText) ||
                contact.familyName.localizedCaseInsensitiveContains(searchText)
            }
        
        // Return both but selected first
        return selected + remaining
    }

    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredContacts, id: \.identifier) { contact in
                    HStack {
                        Button(action: {
                            if let index = selectedNotYetSaved.firstIndex(where: { $0.contactId == contact.identifier }) {
                                selectedNotYetSaved.remove(at: index)
                            } else {
                                selectedNotYetSaved.append(Kyoseiden.userSelectedContacts(contactId: contact.identifier, firstName: contact.givenName, lastName: contact.familyName, lastCalled: Date()))
                            }
                        }) {
                            Image(systemName: (selectedNotYetSaved.firstIndex(where: { $0.contactId == contact.identifier }) != nil) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(.blue)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("\(contact.givenName) \(contact.familyName)")
                            Text("ID: \(contact.identifier)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
            }
            .searchable(text: $searchText)
            .navigationTitle("Contact List")
            .toolbar {
                Button("Save") {
                    
                    for userSelectedContact in userSelectedContacts {
                        if !selectedNotYetSaved.contains(where: { $0.contactId == userSelectedContact.contactId }) {
                            modelContext.delete(userSelectedContact)
                        }
                    }
                    
                    for oneSelectedContact in selectedNotYetSaved {
                        if !userSelectedContacts.contains(where: { $0.contactId == oneSelectedContact.contactId }) {
                            modelContext.insert(oneSelectedContact)
                        }
                    }
                    
                    print("Selected Contacts: ")
                    withAnimation {
                        dismiss()
                    }
                }
            }
            .transition(.slide)
            .onAppear{
                ContactManager.shared.getContactList { fetchedContacts in self.contacts = fetchedContacts }
                self.copySelectedNotYetSaved = self.userSelectedContacts
                self.selectedNotYetSaved = self.copySelectedNotYetSaved.map { $0.copy() as! userSelectedContacts }

            }
            .navigationTitle("Contact List")
        }
    }
   
}

#Preview {
    editFriendList()
}


