//
//  FriendRow.swift
//  60Challenge
//
//  Created by Gucci on 2023/06/04.
//

import SwiftUI

struct FriendRow: View {
    let friend: Friend
    
    var body: some View {
        HStack(alignment: .center) {
            Text(friend.name)
                .font(.title3)
        }
    }
}

struct FriendRow_Previews: PreviewProvider {
    static var previews: some View {
        FriendRow(friend: Friend(id: "", name: "Gucci"))
    }
}
