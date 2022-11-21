//
//  AddressView.swift
//  Cupcake Corner
//
//  Created by YEONGJIN JANG on 2022/11/20.
//

import SwiftUI

struct AddressView: View {
    @Binding var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink {
                    CheckoutView(order: $order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)

        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    @State static var order = Order()
    static var previews: some View {
        AddressView(order: $order)
    }
}
