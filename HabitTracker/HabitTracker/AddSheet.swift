//
//  AddSheet.swift
//  HabitTracker
//
//  Created by YEONGJIN JANG on 2022/11/15.
//

import SwiftUI

struct AddSheet: View {
    @Environment(\.dismiss) private var dismiss

    @State var title = ""
    @State var description = ""
    var onAdded: (Activity) -> Void = { _ in }

    var body: some View {
        NavigationView {
            Form {
                Section("제목") {
                    TextField("제목 입력", text: $title)
                }

                Section("상세") {
                    TextField("상세 내용 입력", text: $description)
                }
            }
            .navigationTitle("활동 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        onAdded(Activity(title, description))
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

struct AddSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddSheet()
    }
}
