//
//  MainViewModel.swift
//  HabitTracker
//
//  Created by YEONGJIN JANG on 2022/11/16.
//

import Foundation

//TODO: - UserDefaults 를 이용한 영구 저장 방식과 Codable 를 이용한 영구 저장 방식의 비교를 하면서 결론을 내자
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

struct User: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
}

class Data: ObservableObject {
    @Published var users: [User] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(users) {
                UserDefaults.standard.set(encoded, forKey: "users")
            }
        }
    }


    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "users") {
            if let decodedItems = try? JSONDecoder().decode([User].self, from: savedItems) {
                users = decodedItems
                return
            }
        }
        users = []
    }
}

