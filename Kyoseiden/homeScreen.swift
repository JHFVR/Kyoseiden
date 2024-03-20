//
//  HomeScreen.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 18.03.24.
//

import SwiftUI

struct ScheduledContact {
    var firstName: String
    var lastName: String
    var callTime: Date
    var profilePicIdentifier: String // Use a placeholder image in the assets
}

// Updated mock data with actual dates and times
let mockContacts: [ScheduledContact] = [
    ScheduledContact(firstName: "John", lastName: "Doe", callTime: Date().addingTimeInterval(3600 * Double.random(in: 6...28)), profilePicIdentifier: "person.fill"),
    ScheduledContact(firstName: "Jane", lastName: "Smith", callTime: Date().addingTimeInterval(3600 * Double.random(in: 30...128)), profilePicIdentifier: "person.fill"),
    ScheduledContact(firstName: "Emily", lastName: "Johnson", callTime: Date().addingTimeInterval(3600 * Double.random(in: 130...234)), profilePicIdentifier: "person.fill")
]

// Updated helper function to format date and time
func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

struct homeScreen: View {
    let contacts = mockContacts
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Text("Up Next")
                        .font(.title)
//                        .foregroundColor(.black) // Explicit text color
                        .frame(maxWidth: .infinity)
                        .padding()
                    ForEach(contacts.indices, id: \.self) { index in
                        HStack {
                            Image(systemName: contacts[index].profilePicIdentifier)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.blue) // Icon color
                                .background(Color.white) // Background color for the icon
                                .clipShape(Circle())
                                .padding(3)
                            
                            VStack(alignment: .leading) {
                                Text("\(contacts[index].firstName) \(contacts[index].lastName)")
                                    .font(.headline)
                                    .foregroundColor(.black) // Ensuring readability
                                Text("Call Time: \(formatDate(contacts[index].callTime))")
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

                    // Action Buttons replaced with NavigationLinks
                    Group {
                        NavigationLink(destination: editSchedule()) {
                            Text("Edit Schedule")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        NavigationLink(destination: editFriendList()) {
                            Text("Edit Friend List")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue) // Blue background for buttons
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20)) // More rounded corners for buttons
                    
                    // Add the hyperlink button at the bottom
                    Link("Send Feedback", destination: URL(string: "mailto:jhfvr@icloud.com?subject=Kyoseiden%20feedback")!)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
            }
            .navigationTitle("Kyoseiden Home")
            .background(Color.blue.opacity(0.05)) // Light blue background for the whole screen
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        homeScreen()
//            .environment(\.colorScheme, .light) // Force light mode for consistency in previews
    }
}

