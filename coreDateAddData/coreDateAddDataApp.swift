//
//  coreDateAddDataApp.swift
//  coreDateAddData
//
//  Created by Pawan Bohora on 7/8/24.
//

import SwiftUI

@main
struct coreDateAddDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
