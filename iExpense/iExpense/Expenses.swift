//
//  Expenses.swift
//  iExpense
//
//  Created by YEONGJIN JANG on 2022/11/02.
//

import Foundation

class Expenses: ObservableObject {
    @Published var bussinessItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(bussinessItems) {
                UserDefaults.standard.set(encoded, forKey: "BussinessItems")
            }
        }
    }

    @Published var personalItems = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(personalItems) {
                UserDefaults.standard.set(encoded, forKey: "PersonalItems")
            }
        }
    }


    init() {
        if let savedBussinessItem = UserDefaults.standard.data(forKey: "BussinessItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedBussinessItem) {
                bussinessItems = decodedItems
                return
            }
        }

        if let savedPersonalItem = UserDefaults.standard.data(forKey: "PersonalItems") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedPersonalItem) {
                personalItems = decodedItems
                return
            }
        }
        
        bussinessItems = []
        personalItems = []
    }
}
