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
    
    // Added initializer to accept contacts
    init(contacts: [CNContact] = []) {
        _contacts = State(initialValue: contacts)
    }
    
    var filteredContacts: [CNContact] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { contact in
                contact.givenName.lowercased().contains(searchText.lowercased()) ||
                contact.familyName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredContacts, id: \.identifier) { contact in
                    HStack {
                        Button(action: {
                            if let index = selectedNotYetSaved.firstIndex(where: { $0.contactId == contact.identifier }) {
                                // If found, remove the instance at the found index
                                selectedNotYetSaved.remove(at: index)
                                
                                for contact in selectedNotYetSaved {
                                    if let lastCalled = contact.lastCalled {
                                        print("Contact ID: \(contact.contactId), Name: \(contact.firstName) \(contact.lastName), Last Called: \(lastCalled)")
                                    } else {
                                        print("Contact ID: \(contact.contactId), Name: \(contact.firstName) \(contact.lastName), Last Called: Not available")
                                    }
                                }
                            } else {
                                selectedNotYetSaved.append(Kyoseiden.userSelectedContacts(contactId: contact.identifier, firstName: contact.givenName, lastName: contact.familyName, lastCalled: Date()))
                                
                                for contact in selectedNotYetSaved {
                                    if let lastCalled = contact.lastCalled {
                                        print("Contact ID: \(contact.contactId), Name: \(contact.firstName) \(contact.lastName), Last Called: \(lastCalled)")
                                    } else {
                                        print("Contact ID: \(contact.contactId), Name: \(contact.firstName) \(contact.lastName), Last Called: Not available")
                                    }
                                }
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
                getContactList()
                self.copySelectedNotYetSaved = self.userSelectedContacts
                self.selectedNotYetSaved = self.copySelectedNotYetSaved.map { $0.copy() as! userSelectedContacts }

            }
            .navigationTitle("Contact List")
        }
    }
    
    func getContactList() {
        let CNStore = CNContactStore()
        
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            do {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactIdentifierKey] as [CNKeyDescriptor]
                let request = CNContactFetchRequest(keysToFetch: keys)
//                var counter = 0
                try CNStore.enumerateContacts(with: request) { contact, stop in
                    self.contacts.append(contact)
//                    counter += 1
//                    // Check if 50 contacts have been fetched
//                    if counter == 50 {
//                        stop.pointee = true // Stops the enumeration
//                    }
                }
            } catch {
                print("Error on contact fetching \(error)")
            }
            
        case .notDetermined:
            CNStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        do {
                            let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactIdentifierKey] as [CNKeyDescriptor]
                            let request = CNContactFetchRequest(keysToFetch: keys)
//                            var counter = 0
                            try CNStore.enumerateContacts(with: request) { contact, stop in
                                self.contacts.append(contact)
//                                counter += 1
//                                // Check if 50 contacts have been fetched
//                                if counter == 50 {
//                                    stop.pointee = true // Stops the enumeration
//                                }
                            }
                        } catch {
                            print("Error on contact fetching \(error)")
                        }
                    }
                } else if let error = error {
                    print("Error requesting contact access: \(error)")
                } else {
                    print("Access denied")
                }
            }
        case .restricted:
            print("Access restricted")
            
        case .denied:
            print("Access denied")
            
        @unknown default:
            print("Unknown authorization status")
        }
    }
}

// Preview Provider with mock data
struct editFriendList_Previews: PreviewProvider {
    static var previews: some View {
        editFriendList(contacts: mockContacts())
    }
    
    static func mockContacts() -> [CNContact] {
        let contact1 = CNMutableContact()
        contact1.givenName = "John"
        contact1.familyName = "Doe"
        // Simulate an identifier
        // Note: In real usage, identifiers are assigned by the system when saving a contact.

        let contact2 = CNMutableContact()
        contact2.givenName = "Jane"
        contact2.familyName = "Smith"
        // Simulate an identifier

        return [contact1 as CNContact, contact2 as CNContact] // Cast to CNContact
    }
}

