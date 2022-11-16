//
//  Activity.swift
//  HabitTracker
//
//  Created by YEONGJIN JANG on 2022/11/16.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {

    var id = UUID()
    var title: String
    var description: String
    var completionCount: Int = 0

    init(_ title: String, _ description: String) {
        self.title = title
        self.description = description
    }

    init() {
        self.init("", "")
    }

    init(_ act: Activity, _ completionCount: Int) {
        self.init(act.title, act.description)
        self.completionCount = completionCount
    }
}
