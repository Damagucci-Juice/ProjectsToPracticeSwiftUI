//
//  ContentView.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let layout = [
            GridItem(.adaptive(minimum: 80, maximum: 120))
        ]
        return ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
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

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}
