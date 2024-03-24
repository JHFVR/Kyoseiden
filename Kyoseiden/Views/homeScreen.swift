//
//  HomeScreen.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 18.03.24.
//

import SwiftUI
import SwiftData

struct homeScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Query private var queriedUserSelectedContacts: [userSelectedContacts]
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    headerView
                    contactsListView
                    actionButtons
                    feedbackLink
                }
                .padding()
            }
            .navigationTitle("Kyoseiden Home")
        }
    }
    
    var headerView: some View {
        Text("Next on call schedule")
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    var contactsListView: some View {

        ForEach(queriedUserSelectedContacts) { contact in
            HStack {
                if let contactImage = getContactImage(contactId: contact.contactId) {
                    contactImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue) // Icon color
                        .background(Color.white) // Background color for the icon
                        .clipShape(Circle())
                        .padding(3)
                } else {
                    // Provide a placeholder image or handle the case when the contact image is not available
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue) // Icon color
                        .background(Color.white) // Background color for the icon
                        .clipShape(Circle())
                        .padding(3)
                }
                
                VStack(alignment: .leading) {
                    Text("\(contact.firstName) \(contact.lastName)")
                        .font(.headline)
                        .foregroundColor(.black) // Ensuring readability
                    Text("Last call: \(contact.lastCalled)")
                        .font(.subheadline)
                        .foregroundColor(.black) // Ensuring readability
                }
                Spacer()
            }
            .padding()
            .background(Color.white.opacity(0.8)) // Light background for each contact row
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 5) // Adding a shadow for depth
        }
    }
    
    var actionButtons: some View {
        Group {
            NavigationLink(destination: editSchedule()) {
                Text("Edit Schedule")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .buttonStyle(PlainButtonStyle()) // Apply button style directly to NavigationLink

            NavigationLink(destination: editFriendList()) {
                Text("Edit Friend List")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .buttonStyle(PlainButtonStyle()) // Apply button style directly to NavigationLink
        }
    }

    
    var feedbackLink: some View {
        Link(destination: URL(string: "mailto:jhfvr@icloud.com?subject=Kyoseiden%20feedback")!) {
            Text("Send Feedback")
                .frame(maxWidth: .infinity) // Maintain button size
                .padding() // Add padding to increase tap area and visual size
                .foregroundColor(.white) // Text color
                .background(Color.green) // Button color
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Rounded corners
        }
        .contentShape(RoundedRectangle(cornerRadius: 10)) // Makes the whole rectangle area tappable, not just the text
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        homeScreen()
    }
}

