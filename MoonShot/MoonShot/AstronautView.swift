//
//  AstronautView.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/04.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()

                ThickDivider()
                    .padding(.horizontal)

                Text("Description")
                    .smallTitle()
                    .padding(.horizontal)

                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
