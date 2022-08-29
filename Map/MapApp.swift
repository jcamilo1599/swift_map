//
//  MapApp.swift
//  Map
//
//  Created by Juan Camilo Marín Ochoa on 29/08/22.
//

import SwiftUI

@main
struct MapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
