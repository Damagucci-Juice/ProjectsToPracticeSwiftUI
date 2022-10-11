//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by YEONGJIN JANG on 2022/10/08.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Choose a correct flag of")
                        .foregroundStyle(.white)
                    Text("\(countries[correctAnswer])")
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        checkAnswer(number)
                    } label: {
                        Label("", image: countries[number])
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("continue", action: askQuestion)
        } message: {
            Text("your score is ???")
        }
    }
    
    private func checkAnswer(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
