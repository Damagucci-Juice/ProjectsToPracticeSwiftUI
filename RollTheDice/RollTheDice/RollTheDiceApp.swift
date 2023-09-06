//
//  RollTheDiceApp.swift
//  RollTheDice
//
//  Created by Gucci on 2023/09/04.
//

import SwiftUI

@main
struct RollTheDiceApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}
