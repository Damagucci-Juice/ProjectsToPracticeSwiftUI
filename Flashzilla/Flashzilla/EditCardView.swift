//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Gucci on 2023/07/09.
//

import SwiftUI

public let filePath = "CardsInfo.json"

struct EditCardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
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
            .onAppear {
                if let loaded: [Card] = loadData() {
                    cards = loaded
                }
            }
        }
    }
    
    private func addCard() {
        guard hasContentsTwoTextField else { return }
        
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
    
    //TODO: - User Defaults -> JSON Documents
    private func loadData<T: Codable>() -> T? {
        guard let url = try? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(filePath),
              let loaded = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(T.self, from: loaded)

    }
    
    private func saveData() {
        guard let url = try? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(filePath) else { return }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        try? encoder.encode(cards).write(to: url)
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
