//
//  ContentView.swift
//  RollTheDice
//
//  Created by Gucci on 2023/09/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var diceSort = 4
    @State private var totalReulst = [DiceResult]()
    @State private var count = 0.0
    @State private var isShowCircle = false
    @State private var randomRange = 1
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: DiceResult.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \DiceResult.timeStamp,
                                                     ascending: false)])
    private var currentDiceResult: FetchedResults<DiceResult>
    private let dices = [4,6,8,12,20,100]
    private let notificationFeedback = UINotificationFeedbackGenerator()
    private let repo = DiceRepository()
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .default).autoconnect()

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
                Button("Roll", action: showCircle)
                Spacer()
                if isShowCircle {
                    Text(randomRange, format: .number)
                } else {
                    Text(totalReulst.last == nil ? "굴린 적 없음" : "\(totalReulst.last?.result ?? 0)")
                }
            }
            .padding(.horizontal)
            
            List(totalReulst) { dice in
                Text(dice.result, format: .number)
            }
            .listStyle(.plain)
        }
        .onAppear {
            notificationFeedback.prepare()
            totalReulst = repo.fetchAll()
        }
        .onReceive(timer) { time in
            guard count <= 3 else {
                timer.upstream.connect().cancel()
                count = 0
                isShowCircle = false
                randomRange = 1
                rollTheDice()
                return
            }
            count += 0.1
            randomRange = Int.random(in: 1...101) % diceSort
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    // TODO: - 저장을 함에 동시에, 업데이트도 같이 하는게 좋음, Repository 방식으로 그냥 빼는 것도 좋아 보임
    private func rollTheDice() {
        let rolledResult = Int.random(in: 1...diceSort)
        
        
        let diceResult = repo.add(rolledResult, target: diceSort)
        totalReulst.append(diceResult)
        notificationFeedback.notificationOccurred(.success)
    }
    
    private func showCircle() {
        isShowCircle = true
        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    }
}
