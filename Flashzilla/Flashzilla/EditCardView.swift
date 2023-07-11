//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Gucci on 2023/07/09.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var deck: CardDeck
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    private var hasContentsTwoTextField: Bool {
        return !trimmedAnswer.isEmpty && !trimmedPrompt.isEmpty
    }
    private var trimmedPrompt: String {
        newPrompt.trimmingCharacters(in: .whitespaces)
    }
    private var trimmedAnswer: String {
        newAnswer.trimmingCharacters(in: .whitespaces)
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $newPrompt)
                    TextField("Answer", text: $newAnswer)
                    Button("Add card", action: addCard)
                        .disabled(!hasContentsTwoTextField)
                        .foregroundColor(hasContentsTwoTextField ? Color.blue : .gray)
                }
                
                Section {
                    ForEach(0..<deck.cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(deck.cards[index].prompt)
                                .font(.headline)
                            Text(deck.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCards)
                }
            }
            .navigationTitle("Edit Card")
            .toolbar {
                Button("Done", action: done)
            }
            .listStyle(.grouped)
            .onAppear {
                deck.resetCards()
            }
        }
    }
    
    private func addCard() {
        guard hasContentsTwoTextField else { return }
        
        let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        deck.addCard(newCard)
        clearTextField()
    }
    
    private func clearTextField() {
        newPrompt = ""
        newAnswer = ""
    }
    
    private func removeCards(at offsets: IndexSet) {
        deck.removeCard(at: offsets)
    }
    
    private func done() {
        dismiss()
    }
}

struct EditCardView_Previews: PreviewProvider {
    static let deck = CardDeck()
    
    static var previews: some View {
        EditCardView()
            .environmentObject(deck)
    }
}
