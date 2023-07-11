//
//  View+extensions.swift
//  Flashzilla
//
//  Created by Gucci on 2023/07/11.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
