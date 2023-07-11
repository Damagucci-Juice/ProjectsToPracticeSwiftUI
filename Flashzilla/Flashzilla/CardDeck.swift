//
//  CardDeck.swift
//  Flashzilla
//
//  Created by Gucci on 2023/07/10.
//

import SwiftUI

final class CardDeck: ObservableObject {
    @Published private(set) var cards: [Card] {
        didSet {
            saveData(cards)
        }
    }
    static let filePath = "CardsInfo.json"
    
    init() {
        if let loaded: [Card] = loadData() {
            cards = loaded
            return 
        }
        cards = []
    }
    
    func addCard(_ card: Card) {
        cards.append(card)
    }

    func removeCard(at index: Int) {
        cards.remove(at: index)
    }
    
    func removeCard(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
    }
    
    func resetCards() {
        if let cards: [Card] = loadData() {
            self.cards = cards
        }
    }
}

fileprivate func loadData<T: Codable>() -> T? {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
        .appendingPathComponent(CardDeck.filePath),
          let loaded = try? Data(contentsOf: url) else { return nil }
    
    return try? JSONDecoder().decode(T.self, from: loaded)
}

fileprivate func saveData<T: Codable>(_ arr: [T]) {
    guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
        .appendingPathComponent(CardDeck.filePath) else { return }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    try? encoder.encode(arr).write(to: url)
}
