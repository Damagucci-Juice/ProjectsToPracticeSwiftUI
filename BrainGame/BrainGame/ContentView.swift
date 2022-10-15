//
//  ContentView.swift
//  BrainGame
//
//  Created by YEONGJIN JANG on 2022/10/15.
//

import SwiftUI

enum RockScissorsPaper: String, CaseIterable {
    case rock = "✊"
    case paper = "✋"
    case scissors = "👉"

    static func randomElement() -> Self {
        return Self.allCases.randomElement() ?? .rock
    }

    func answerOf(_ question: Bool) -> Self {
        if question {
            switch self {
            case .rock:
                return .paper
            case .paper:
                return .scissors
            case .scissors:
                return .rock
            }
        } else {
            switch self {
            case .rock:
                return .scissors
            case .paper:
                return .rock
            case .scissors:
                return .paper
            }
        }
    }
}

struct ContentView: View {

    var moves: [RockScissorsPaper] = RockScissorsPaper.allCases
    @State private var isWin: Bool = Bool.random()
    @State private var scores: Int = 0
    @State private var showAlert = false
    @State private var gameCount = 0
    @State var randomMove = RockScissorsPaper.randomElement()

    var body: some View {
        VStack(alignment: .center) {
            Text("brain game")
                .font(.largeTitle)

            Text("your Score is \(scores)")
                .padding(.top, 10)

            HStack {
                let winOrLose = isWin ? "Win" : "Lose"
                Text(winOrLose)
                    .font(.title)
                Text("to")
                    .font(.title)
                Text(randomMove.rawValue)
                    .bigText()
            }
            .padding(.top, 10)

            ForEach(moves, id: \.self) { move in
                Button {
                    calculateScore(move)
                } label: {
                    Text(move.rawValue)
                        .bigText()
                }
            }

            Spacer()
        }
        .padding()
        .alert("your score is \(scores)",isPresented: $showAlert) {
            Button("restart") {
                resetGame()
            }
        }
    }

    private func calculateScore(_ choice: RockScissorsPaper) {
        let correctAnswer = randomMove.answerOf(isWin)
        if correctAnswer == choice {
            scores += 1
        }
        isWin.toggle()
        gameCount += 1
        randomMove = RockScissorsPaper.randomElement()
        if gameCount == 10 {
            showAlert.toggle()
        }
    }

    func resetGame() {
        gameCount = 0
        scores = 0
        isWin = Bool.random()
        randomMove = RockScissorsPaper.randomElement()
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
