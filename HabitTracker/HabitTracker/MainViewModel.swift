//
//  MainViewModel.swift
//  HabitTracker
//
//  Created by YEONGJIN JANG on 2022/11/16.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var activites: [Activity] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(activites) {
                UserDefaults.standard.set(encoded, forKey: "activites")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "activites") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                activites = decodedItems
                return
            }
        }

        activites = []
    }

    func addActivity(_ act: Activity) {
        activites.append(act)
    }

    func remove(_ offSet: IndexSet) {
        activites.remove(atOffsets: offSet)
    }

    func update(_ act: Activity, _ count: Int) {
        guard let index = activites.firstIndex(of: act) else { return }
        activites[index] = Activity(act, count)
    }
}
