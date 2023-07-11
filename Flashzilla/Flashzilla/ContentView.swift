//
//  ContentView.swift
//  Flashzilla
//
//  Created by Gucci on 2023/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    @EnvironmentObject var deck: CardDeck
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @Environment(\.scenePhase) var scenePhase
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(deck.cards) { card in
                        if let index = deck.cards.firstIndex(where: {$0.id == card.id}) {
                            CardView(card: card) { isIncorrect in
                                withAnimation {
                                    let card = card
                                    if isIncorrect {
                                        addCard(card)
                                    }
                                    removeCard(at: index)
                                }
                            }
                            .stacked(at: index, in: deck.cards.count)
                            .allowsHitTesting(index == deck.cards.count-1)
                            .accessibilityHidden(index < deck.cards.count - 1)
                        }
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if deck.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                removeCard(at: deck.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrected")
                        
                        Spacer()
                        Button {
                            withAnimation {
                                removeCard(at: deck.cards.count - 1)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) { newValue in
            if newValue == .active {
                if !deck.cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCardView.init)
        .onAppear(perform: resetCards)
        .persistentSystemOverlays(.hidden)
    }
    
    private func resetCards() {
        timeRemaining = 100
        isActive = true
        deck.resetCards()
    }
    
    private func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        deck.removeCard(at: index)
        if deck.cards.isEmpty {
            isActive = false
        }
    }
    
    private func addCard(_ card: Card) {
        let newCard = Card(prompt: card.prompt, answer: card.answer)
        deck.addCard(newCard)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let deck = CardDeck()
    
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
            .environmentObject(deck)
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}
