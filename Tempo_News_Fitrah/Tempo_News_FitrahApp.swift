//
//  Tempo_News_FitrahApp.swift
//  Tempo_News_Fitrah
//
//  Created by Laptop MCO on 13/08/23.
//

import SwiftUI

@main
struct Tempo_News_FitrahApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
