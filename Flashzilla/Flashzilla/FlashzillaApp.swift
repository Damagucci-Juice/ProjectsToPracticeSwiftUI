//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Gucci on 2023/06/23.
//

import SwiftUI

@main
struct FlashzillaApp: App {
    @StateObject var cardDeck = CardDeck()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cardDeck)
        }
    }
}
