//
//  SelectTableView.swift
//  Multiplication
//
//  Created by YEONGJIN JANG on 2022/10/31.
//

import SwiftUI

struct SelectTableView: View {
    @State var table: Int = 2
    @State var questions: [Int] = [5,10,20]
    @State var questionCount = 5
    @State private var pulseAmount = 0.0
    var body: some View {
        NavigationView {
            VStack {
                Section("Which table do you want") {
                    HStack {
                        Text("Up to \(table)")
                        Spacer()
                        Stepper("", value: $table, in: 2...12)
                            .labelsHidden()
                    }
                }
                .padding(.top, 20)

                Section("how many questions do you want to solve?") {
                    Picker("", selection: $questionCount) {
                        ForEach(questions, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                }
                .padding(.top, 30)

                Spacer()

                NavigationLink {
                    QuestionView(table: table, maxQuestion: questionCount)
                } label: {
                    Text("\(table)단 시작!")
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .font(.title)
                    .background(.red)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(.red)
                            .scaleEffect(pulseAmount)
                            .opacity((2 - pulseAmount))
                            .animation(
                                .easeOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                value: pulseAmount
                            )
                    )
                    .onAppear {
                        pulseAmount = 2
                    }
                }




                Spacer()
            }
            .navigationTitle("Multiplication")
            .padding(.horizontal)
        }
    }
}

struct SelectTableView_Previews: PreviewProvider {
    static var previews: some View {
        SelectTableView()
    }
}
