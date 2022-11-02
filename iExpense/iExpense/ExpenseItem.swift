//
//  ExpenseItem.swift
//  iExpense
//
//  Created by YEONGJIN JANG on 2022/11/02.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
