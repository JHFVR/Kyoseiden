//
//  KyoseidenApp.swift
//  Kyoseiden
//
//  Created by VON RUEDEN, Jonathan on 14.03.24.
//

import SwiftUI
import SwiftData

@main
struct KyoseidenApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            userSelectedContacts.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            homeScreen()
        }
        
// Save for later to switch between initial setup and already set up users
//        WindowGroup {
//            if userIsLoggedIn {
//                DashboardView()
//            } else {
//                LoginView()
//            }
//        }
        .modelContainer(sharedModelContainer)
    }
}

