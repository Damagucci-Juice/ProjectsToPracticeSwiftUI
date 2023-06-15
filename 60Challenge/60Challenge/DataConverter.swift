//
//  DataConverter.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import Foundation
import CoreData

class DataConverter {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func convert(from users: [User]) {
        users.forEach { user in
            convertUser(user)
        }
        
        if context.hasChanges {
            try? context.save()
        }
    }
    
    private func convertUser(_ user: User) {
        let cachedUser = CachedUser(context: context)
        cachedUser.id = user.id
        cachedUser.isActive = user.isActive
        cachedUser.name = user.name
        cachedUser.age = Int16(user.age)
        cachedUser.company = user.company
        cachedUser.email = user.email
        cachedUser.address = user.address
        cachedUser.about = user.about
        cachedUser.registered = user.registered
        cachedUser.tags = user.tags.joined(separator: ",")
        cachedUser.friend = NSSet(array: convertFriend(user.friends, with: cachedUser))
    }
    
    private func convertFriend(_ friends: [Friend], with user: CachedUser) -> [CachedFriend] {
        friends.map { friend in
            let cachedFriend = CachedFriend(context: context)
            cachedFriend.id = friend.id
            cachedFriend.name = friend.name
            cachedFriend.origin = user
            return cachedFriend
        }
    }
}
