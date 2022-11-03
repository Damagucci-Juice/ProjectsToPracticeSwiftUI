//
//  ContentView.swift
//  iExpense
//
//  Created by YEONGJIN JANG on 2022/11/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                Section("Personal") {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount,
                                 format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundColor(item.amount >= 100000.0 ? .red : (item.amount <= 1000.0 ? .green : .primary))
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }

                Section("Bussiness") {
                    ForEach(expenses.bussinessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount,
                                 format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundColor(item.amount >= 100000.0 ? .red : (item.amount <= 1000.0 ? .green : .primary))
                        }
                    }
                    .onDelete(perform: removeBussinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true 
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }

    private func removeBussinessItems(at offSet: IndexSet) {
        expenses.bussinessItems.remove(atOffsets: offSet)
    }

    private func removePersonalItems(at offSet: IndexSet) {
        expenses.personalItems.remove(atOffsets: offSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
