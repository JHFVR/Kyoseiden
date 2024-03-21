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
        Text("Up Next")
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    var contactsListView: some View {

        ForEach(queriedUserSelectedContacts) { contact in
            HStack {
                Image(systemName: String(contact.contactId))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue) // Icon color
                    .background(Color.white) // Background color for the icon
                    .clipShape(Circle())
                    .padding(3)
                
                VStack(alignment: .leading) {
                    Text("\(contact.firstName) \(contact.lastName)")
                        .font(.headline)
                        .foregroundColor(.black) // Ensuring readability
                    Text("Last call: \(contact.lastCalled)")
                        .font(.subheadline)
                        .foregroundColor(.gray) // Ensuring readability
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
            }
            NavigationLink(destination: editFriendList()) {
                Text("Edit Friend List")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    var feedbackLink: some View {
        Link("Send Feedback", destination: URL(string: "mailto:jhfvr@icloud.com?subject=Kyoseiden%20feedback")!)
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}





//struct homeScreen: View {
//    let contacts = mockContacts
//    
//    @Environment(\.modelContext) private var modelContext
//    @Environment(\.dismiss) var dismiss
//    
//    @Query private var queriedUserSelectedContacts: [userSelectedContacts] // Renamed for clarity
//    
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(alignment: .center, spacing: 20) {
//                    Text("Up Next")
//                        .font(.title)
////                        .foregroundColor(.black) // Explicit text color
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                    ForEach(queriedUserSelectedContacts) { contact in
//                        // Use 'contact' directly, no need for 'index'
//                        HStack {
////                            Image(systemName: Int(queriedUserSelectedContacts.contactId))
////                                .resizable()
////                                .scaledToFit()
////                                .frame(width: 60, height: 60)
////                                .foregroundColor(.blue) // Icon color
////                                .background(Color.white) // Background color for the icon
////                                .clipShape(Circle())
////                                .padding(3)
//                            
//                            VStack(alignment: .leading) {
//                                Text("\(queriedUserSelectedContacts.firstName) \(queriedUserSelectedContacts.lastName)")
//                                    .font(.headline)
//                                    .foregroundColor(.black) // Ensuring readability
//                                Text("Last call: \(formatDate(queriedUserSelectedContacts.lastCalled))")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray) // Ensuring readability
//                            }
//                            Spacer()
//                        }
//                        .padding()
//                        .background(Color.white.opacity(0.8)) // Light background for each contact row
//                        .clipShape(RoundedRectangle(cornerRadius: 20))
//                        .shadow(radius: 5) // Adding a shadow for depth
//                    }
//
//                    // Action Buttons replaced with NavigationLinks
//                    Group {
//                        NavigationLink(destination: editSchedule()) {
//                            Text("Edit Schedule")
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                        }
//                        
//                        NavigationLink(destination: editFriendList()) {
//                            Text("Edit Friend List")
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue) // Blue background for buttons
//                    .foregroundColor(.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 20)) // More rounded corners for buttons
//                    
//                    // Add the hyperlink button at the bottom
//                    Link("Send Feedback", destination: URL(string: "mailto:jhfvr@icloud.com?subject=Kyoseiden%20feedback")!)
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.green)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                }
//                .padding()
//            }
//            .navigationTitle("Kyoseiden Home")
//            .background(Color.blue.opacity(0.05)) // Light blue background for the whole screen
//        }
//    }
//}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        homeScreen()
//            .environment(\.colorScheme, .light) // Force light mode for consistency in previews
    }
}

