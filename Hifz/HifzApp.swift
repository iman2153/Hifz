//
//  HifzApp.swift
//  Hifz
//
//  Created by Iman Morshed on 12/8/24.
//

import SwiftUI

@main
struct HifzApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
