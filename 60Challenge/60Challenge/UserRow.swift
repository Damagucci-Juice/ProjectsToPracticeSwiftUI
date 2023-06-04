//
//  UserRow.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import SwiftUI

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack(alignment: .center) {
            Circle()
                .foregroundColor(user.isActive ? .green : .clear)
                .frame(width: 15)
            
            Text(user.name)
                .font(.title3)
            
        }
    }
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: User(id: "", isActive: true, name: "gucci", age: 0, company: "", email: "", address: "", about: "", registered: .now, tags: [], friends: []))
    }
}
