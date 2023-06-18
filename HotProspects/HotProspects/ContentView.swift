//
//  ContentView.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import SwiftUI
import SamplePackage

struct ContentView: View {
    let possibles = Array(1...60)
    var results: String {
        let selected = possibles.random(7).sorted()
        let str = selected.map(String.init)
        return str.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
