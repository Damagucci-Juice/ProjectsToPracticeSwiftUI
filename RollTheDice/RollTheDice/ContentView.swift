//
//  ContentView.swift
//  RollTheDice
//
//  Created by Gucci on 2023/09/04.
//

import SwiftUI

struct ContentView: View {
    @State private var diceSort = 4
    @State private var totalReulst = [Int]()
    @Environment(\.managedObjectContext) var context
    
//    @FetchRequest(
//        entity: DiceResult.entity(),
////        sortDescriptors: [SortDescriptor]
//    )
//    private var currentDiceResult: FetchedResults<DiceResult>
    
    private let dices = [4,6,8,12,20,100]
    private let notificationFeedback = UINotificationFeedbackGenerator()

    private var rolledResult: Int {
        totalReulst.isEmpty ? 0 : totalReulst.last ?? 0
    }
    
    var body: some View {
        VStack {
            // 주사위 선택 픽커
            Section {
                Picker("Select dice", selection: $diceSort) {
                    ForEach(dices, id: \.self) { dice in
                        Text(dice, format: .number)
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                HStack {
                    Text("Select Dice")
                    Spacer()
                }
            }
            .padding(.horizontal)
            
            // 주사위 던지기 버튼
            HStack {
                Button("Roll", action: rollTheDice)
                Spacer()
                
                Text(rolledResult == 0 ? "굴린 적 없음" : "\(rolledResult)")
            }
            .padding(.horizontal)
            
            List(totalReulst, id: \.self) { dice in
                Text(dice, format: .number)
            }
            .listStyle(.plain)
        }
        .onAppear {
            notificationFeedback.prepare()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    private func rollTheDice() {
        let rolledResult = Int.random(in: 1...diceSort)
        totalReulst.append(rolledResult)
        
        notificationFeedback.notificationOccurred(.success)
    }
}
