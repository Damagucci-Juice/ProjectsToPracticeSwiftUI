//
//  MainView.swift
//  HabitTracker
//
//  Created by YEONGJIN JANG on 2022/11/15.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @State var showAddSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.activites) { act in
                    NavigationLink {
                        ActivityDetailView(activity: act,
                                           viewModel: viewModel)
                    } label: {
                        HStack {
                            Text(act.title)
                            Spacer()
                            Text("completion: \(act.completionCount)")
                                .font(.caption)
                        }
                    }
                }
                .onDelete(perform: viewModel.remove)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            AddSheet(onAdded: viewModel.addActivity)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
