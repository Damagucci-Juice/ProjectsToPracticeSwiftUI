//
//  LargeImage.swift
//  BrainGame
//
//  Created by YEONGJIN JANG on 2022/10/15.
//

import SwiftUI

struct BigText: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(width: 150, height: 150)
            .font(.system(size: 48))
    }
}

extension View {
    func bigText() -> some View {
        modifier(BigText())
    }
}
