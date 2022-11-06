//
//  ContentView.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/03.
//

import SwiftUI

struct ContentView: View {
    private let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    private let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingGrid = true

    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayoutView(missions: missions, astronauts: astronauts)
                } else {
                    ListLayoutView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Toggle(isOn: $showingGrid) {
                    Text("show grid")
                }
                .toggleStyle(.switch)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
