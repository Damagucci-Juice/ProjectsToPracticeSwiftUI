//
//  NotifyList.swift
//  NotiWatch
//
//  Created by YEONGJIN JANG on 2022/10/12.
//

import SwiftUI

struct NotifyList: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGray5)
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: 25) {
                        ForEach(0..<3) { _ in
                            TaskView()
                        }
                    }
                    .padding(20)
                }
                .navigationTitle("오늘의 미션")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            print("hello world")
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            
        }
    }
}

struct MissionList_Previews: PreviewProvider {
    static var previews: some View {
        NotifyList()
    }
}
