//
//  DiceResult+CoreDataProperties.swift
//  RollTheDice2
//
//  Created by Gucci on 2023/09/06.
//
//

import Foundation
import CoreData


extension DiceResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiceResult> {
        return NSFetchRequest<DiceResult>(entityName: "DiceResult")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var result: Int16
    @NSManaged public var targetDice: Int16
    @NSManaged public var timeStamp: Date?

}

extension DiceResult : Identifiable {

}
