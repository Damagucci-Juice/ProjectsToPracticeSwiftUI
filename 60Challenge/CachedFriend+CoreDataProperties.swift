//
//  CachedFriend+CoreDataProperties.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var origin: CachedUser?

}

extension CachedFriend : Identifiable {
    var wrappedID: String {
        id ?? "Unknown ID"
    }
    
    var wrappedName: String {
        name ?? "Unknown"
    }
}
