//
//  Prospects.swift
//  HotProspects
//
//  Created by Gucci on 2023/06/18.
//

import SwiftUI

class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
}
