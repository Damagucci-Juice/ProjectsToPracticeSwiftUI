//
//  ListLayoutView.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/07.
//

import SwiftUI

struct ListLayoutView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]

    var body: some View {
        GeometryReader { geo in
            List(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack(alignment: .center, spacing: 18) {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: geo.size.width * 0.1)
                            .frame(width: 50, height: 50)

                        Text(mission.displayName)
                            .font(.headline.bold())

                        Text(mission.formattedLaunchDate)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.darkBackground)
        }
    }
}

struct ListLayoutView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        ListLayoutView(missions: missions, astronauts: astronauts)
    }
}
