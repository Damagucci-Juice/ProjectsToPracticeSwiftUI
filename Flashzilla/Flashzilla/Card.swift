//
//  Card.swift
//  Flashzilla
//
//  Created by Gucci on 2023/07/07.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "영국의 수도는?", answer: "런던")
}
