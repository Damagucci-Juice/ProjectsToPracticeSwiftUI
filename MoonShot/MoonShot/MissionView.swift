//
//  MissionView.swift
//  MoonShot
//
//  Created by YEONGJIN JANG on 2022/11/04.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]

    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    Text(mission.longLaunchDate)
                        .font(.headline)
                        .padding(.top, 10)


                    VStack(alignment: .leading) {
                        ThickDivider()

                        Text("Mission Highlights")
                            .smallTitle()

                        Text(mission.description)

                        ThickDivider()

                        Text("Crew")
                            .smallTitle()
                    }
                    .padding(.horizontal)

                    CrewBadgeView(crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[2], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
