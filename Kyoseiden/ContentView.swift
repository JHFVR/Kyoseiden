//
//  ContentView.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//
import SwiftUI
import Contacts
import SwiftData

struct ContentView: View {
    @State var contacts = [CNContact]()
    
    var body: some View {
        NavigationView {
            List(contacts, id: \.identifier) { contactDetail in
                HStack(spacing: 10){
                    Image("Rectangle 47")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .animation(.linear, value: 3)
                    VStack(alignment: .leading, spacing: 10){
                        Text("\(contactDetail.givenName) \(contactDetail.familyName)")
                        Text("ID: \(contactDetail.identifier)") // Display the identifier
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }.multilineTextAlignment(.leading)
                    Spacer()
                    Image("Call")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .transition(.slide)
            .onAppear(perform: getContactList())
            .navigationTitle("Contact List")
        }
    }
}

// Preview Provider with mock data
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(contacts: mockContacts())
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
