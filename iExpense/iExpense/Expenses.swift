//
//  Expenses.swift
//  iExpense
//
//  Created by YEONGJIN JANG on 2022/11/02.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }

    var personalExpenses: [ExpenseItem] { return items.filter { $0.type == "Personal" } }
    var bussinessExpenses: [ExpenseItem] { return items.filter { $0.type == "Bussiness" } }

    init() {
        if let savedItem = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItem) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
