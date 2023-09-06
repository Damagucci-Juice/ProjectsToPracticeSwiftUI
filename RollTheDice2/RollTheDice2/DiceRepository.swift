//
//  DiceRepository.swift
//  RollTheDice2
//
//  Created by Gucci on 2023/09/06.
//

import Foundation
import CoreData

@MainActor
final class DiceRepository: ObservableObject {
    // A singleton for our entire app to use
    static let shared = DiceRepository()
    
    // Storage for Core Data
    let container: NSPersistentContainer
    
    // A test configuration for SwiftUI previews
    static var preview: DiceRepository = {
        let controller = DiceRepository(inMemory: true)
        let context = controller.container.viewContext
        
        for _ in 0..<10 {
            let diceResult = DiceResult(context: context)
            diceResult.id = UUID()
            diceResult.result = Int16.random(in: 1...6)
            diceResult.targetDice = 6
            diceResult.timeStamp = Date()
        }
        
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RollTheDice")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    @discardableResult
    func add(_ number: Int, target dice: Int) -> DiceResult {
        let context = container.viewContext
        let diceResult = create(number, target: dice, in: context)
        
        context.performAndWait {
            do {
                try save()
            } catch {
                print(error)
            }
        }
        return diceResult
    }
    
    func save() throws {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    fileprivate func create(_ number: Int, target dice: Int, in context: NSManagedObjectContext) -> DiceResult {
        let result = DiceResult(context: context)
        result.id = UUID()
        result.targetDice = Int16(dice)
        result.result = Int16(number)
        result.timeStamp = Date()
        return result
    }
    
    func fetchAll() -> [DiceResult] {
        let request = DiceResult.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DiceResult.timeStamp, ascending: true)]
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("fetch Person error: \(error)")
            return []
        }
    }
}
