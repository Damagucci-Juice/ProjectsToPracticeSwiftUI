//
//  RollTheDice2App.swift
//  RollTheDice2
//
//  Created by Gucci on 2023/09/06.
//

import SwiftUI
import CoreData

@main
struct RollTheDice2App: App {
    @StateObject var diceRepo = DiceRepository.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              diceRepo.container.viewContext)
        }
    }
}
