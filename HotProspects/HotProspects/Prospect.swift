//
//  Prospect.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}
