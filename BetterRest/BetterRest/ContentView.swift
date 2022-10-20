//
//  ContentView.swift
//  BetterRest
//
//  Created by YEONGJIN JANG on 2022/10/17.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isCalculateSuccess = false


    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("How do you want to wake up?")
                        .font(.headline)
                }

                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                }

                Section {
                    Picker(coffeeAmount == 0 ? "1 cup" : "\(coffeeAmount + 1) cups", selection: $coffeeAmount) {
                        ForEach(1..<21) { number in
                            Text("\(number) cup")
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                        .font(.headline)
                }

                Section {
                    Text(calculateBedTime())
                        .font(.largeTitle)
                } header: {
                    Text("Your ideal bedtime is...")
                        .font(.largeTitle)
                }
            }
            .navigationTitle("BetterRest")
        }
    }

    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount + 1))

            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
