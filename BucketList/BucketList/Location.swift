//
//  Location.swift
//  BucketList
//
//  Created by Gucci on 2023/06/16.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
