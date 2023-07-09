//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Gucci on 2023/07/09.
//

import SwiftUI

struct EditCardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    private var isAddCardEnabled: Bool {
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
                        .disabled(isAddCardEnabled)
                        .foregroundColor(isAddCardEnabled ? Color.blue : .gray)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
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
            .onAppear(perform: loadData)
        }
    }
    
    private func addCard() {
        guard isAddCardEnabled else { return }
        
        let card = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(card, at: 0)
        saveData()
        clearTextField()
    }
    
    private func clearTextField() {
        newPrompt = ""
        newAnswer = ""
    }
    
    private func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    
    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    private func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    private func done() {
        dismiss()
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardView()
    }
}
