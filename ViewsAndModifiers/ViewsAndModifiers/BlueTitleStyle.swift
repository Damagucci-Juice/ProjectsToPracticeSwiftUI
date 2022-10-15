//
//  BlueTitleStyle.swift
//  ViewsAndModifiers
//
//  Created by YEONGJIN JANG on 2022/10/15.
//

import SwiftUI

struct BlueTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.blue)
            .font(.largeTitle.bold())
    }
}

extension View {
    func blueTitleStyle() -> some View {
        modifier(BlueTitleStyle())
    }
}
