//
//  QuestionView.swift
//  Multiplication
//
//  Created by YEONGJIN JANG on 2022/10/31.
//

import SwiftUI

struct QuestionView: View {
    let table: Int
    let maxQuestion: Int
    @Environment(\.dismiss) var dismiss
    @State private var multipliers: [Int] = [2,3,4,5,6,7,8,9].shuffled()
    @State private var score = 0
    @State private var currentQuestion = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isEnd = false
    init(table: Int, maxQuestion: Int) {
        self.table = table
        self.maxQuestion = maxQuestion
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray4)
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text(table, format: .number)
                        Text("X")
                        Text(multipliers[correctAnswer], format: .number)
                        Text("= ")
                        Image(systemName: "questionmark")
                    }
                    .font(.title)
                    List {
                        ForEach(0..<3) { num in
                            Button("\(multipliers[num] * table)") {
                                if checkAnswer(num) {
                                    self.score += 1
                                }
                                askQuestion()
                            }
                        }
                    }
                    .padding(.top, 30)
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .navigationTitle("\(table)단")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .alert("end Game", isPresented: $isEnd) {
            Button("Restart") {
                resetGames()
            }
            Button("no") {
                dismiss()
            }
        } message: {
            Text("your final score is \(score)")
        }
    }

    private func checkAnswer(_ num: Int) -> Bool {
        return correctAnswer == num
    }

    private func askQuestion() {
        multipliers = multipliers.shuffled()
        correctAnswer = Int.random(in: 0...2)
        currentQuestion += 1
        isEnd = maxQuestion == currentQuestion ? true : false
    }

    private func resetGames() {
        score = 0
        currentQuestion = 0
        askQuestion()
    }
}

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView()
//    }
//}
