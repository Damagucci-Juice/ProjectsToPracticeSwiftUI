//
//  ContentView.swift
//  AccessibilityProject
//
//  Created by Gucci on 2023/06/17.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
        ZStack {
            Image(decorative: pictures[selectedPicture])
                .accessibilityHidden(true)
            
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your score is 1000")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
