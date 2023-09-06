//
//  PersistenceContoller.swift
//  RollTheDice
//
//  Created by Gucci on 2023/09/05.
//

import Foundation
import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let targetNumber = 4
        
        // Create 10 example Dice Result
//        for _ in 0..<10 {
//            let result = DiceResult(context: controller.container.viewContext)
//            result.id = UUID()
//            result.number = Int.random(in: 1...targetNumber)
//            result.dice = targetNumber
//        }

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "Main")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() throws {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("save failed")
            }
        }
    }
}
