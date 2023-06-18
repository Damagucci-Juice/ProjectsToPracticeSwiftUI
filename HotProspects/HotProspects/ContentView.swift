//
//  ContentView.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello world")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    Button("Green") {
                        backgroundColor = .green
                    }
                    Button("Blue") {
                        backgroundColor = .blue
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
