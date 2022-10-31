//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by YEONGJIN JANG on 2022/10/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = [
        "Estonia", "France", "Germany",
        "Ireland", "Italy", "Nigeria",
        "Poland", "Russia", "Spain",
        "UK", "US"
    ].shuffled()
    @State private var scores = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var gameCount = 0
    @State private var showingFinalScore = false
    @State private var animationAmount = 0.0
    @State private var isTappedArray: [Bool] = [true, true, true]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Choose a correct flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            checkAnswer(number)
                            withAnimation {
                                animationAmount += 360
                                for i in 0..<3 {
                                    if i != number {
                                        isTappedArray[i].toggle()
                                    }
                                }
                            }
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                                .blur(radius: isTappedArray[number] ? 0 : 3)
                                .scaleEffect(x: isTappedArray[number] ? 1 : 0.5,
                                             y: isTappedArray[number] ? 1 : 0.5)
                                .animation(.default, value: isTappedArray[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scores)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Text("Game Count: \(gameCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())

                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("continue", action: askQuestion)
        } message: {
            Text("your score is \(scores)")
        }
        .alert("game over", isPresented: $showingFinalScore) {
            Button("restart", role: .cancel, action: restartGame)
        } message: {
            Text("Your final score is \(scores)")
        }
    }
    
    private func checkAnswer(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scores += 1
        } else {
            scoreTitle = """
                        Wrong!
                        That's the flag of \(countries[number])
                        """
            if scores > 0 {
                scores -= 1
            }
        }

        gameCount += 1
        if gameCount == 8 {
            showingFinalScore = true
        } else {
            showingScore = true
        }
    }

    private func restartGame() {
        askQuestion()
        scores = 0
        gameCount = 0
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isTappedArray = [true, true, true]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
