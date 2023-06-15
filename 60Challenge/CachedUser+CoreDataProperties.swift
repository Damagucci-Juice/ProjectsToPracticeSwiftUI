//
//  CachedUser+CoreDataProperties.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friend: NSSet?

}

// MARK: Generated accessors for friend
extension CachedUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CachedFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CachedFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CachedUser : Identifiable {
    var wrappedID: String {
        id ?? "Unknown ID"
    }
    
    var wrappedName: String {
        name ?? "Unknown"
    }
    
    var refinedAge: Int {
        Int(age)
    }
    
    var wrappedCompany: String {
        company ?? "Unknown"
    }
    
    var wrappedEmail: String {
        email ?? "Unknwon"
    }
    
    var wrappedAddress: String {
        address ?? "Unknown"
    }
    
    var wrappedAbount: String {
        about ?? "Unknown"
    }
    
    var wrappedDate: Date {
        registered ?? .distantPast
    }
    
    var tagArr: [String] {
        let tags = tags ?? ""
        return tags.components(separatedBy: ",")
    }
    
    var friends: [CachedFriend] {
        let set = friend as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
