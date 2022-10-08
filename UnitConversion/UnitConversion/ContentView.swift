//
//  ContentView.swift
//  UnitConversion
//
//  Created by YEONGJIN JANG on 2022/10/07.
//

import SwiftUI

struct ContentView: View {
    
    enum Length: Double, CaseIterable {
        var id: String {
            return "\(self)"
        }
        case meter = 1.0
        case kilometer = 1000.0
        case foot = 3.281
        case yard = 1.094
        case mile = 1609.0
    }
    @State private var inputValue = 0.0
    @State private var inputUnit = Length.meter
    @State private var outputUnit = Length.meter
    @FocusState private var inputIsFocused: Bool
    
    private var inputResult: Double {
        switch inputUnit {
        case .foot, .yard:
            return inputValue / inputUnit.rawValue
        default:
            return inputValue * inputUnit.rawValue
        }
    }
    
    private var outputResult: Double {
        switch outputUnit {
        case .kilometer, .mile:
            return inputResult / outputUnit.rawValue
        default:
            return inputResult * outputUnit.rawValue
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Select input unit", selection: $inputUnit) {
                        ForEach(Length.allCases, id: \.self) {
                            Text($0.id)
                        }
                    }
                } header: {
                    Text("Input")
                }
                
                Section {
                    Text(outputResult.formatted())
                    
                    Picker("Select output unit", selection: $outputUnit) {
                        ForEach(Length.allCases, id: \.self) {
                            Text($0.id)
                        }
                    }
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Conversion - Length")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
