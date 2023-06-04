//
//  User.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company, email, address, about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
