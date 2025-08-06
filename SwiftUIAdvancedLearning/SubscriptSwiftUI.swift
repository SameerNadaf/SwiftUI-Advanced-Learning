//
//  SubscriptSwiftUI.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 31/07/25.
//

import SwiftUI

struct Customer {
    let id: String = UUID().uuidString
    let firstName: String
    let lastName: String
    let age: Int
    let isPremium: Bool
    
    subscript(value: String) -> String? {
        switch value {
        case "firstName": return firstName
        case "lastName": return lastName
        default: return nil
        }
    }
}

extension Array {
    subscript(atIndex: Double) -> Element? {
        for (index, element) in self.enumerated() {
            if index == Int(atIndex) {
                return element
            }
        }
        return nil
    }
}

struct SubscriptSwiftUI: View {
    
    let array: [Int] = [1,2,3,4,5,6]
    @State var selectedField: String? = nil
    
    var body: some View {
        VStack {
            let arrayItem = array[4.0]
            Text("\(arrayItem ?? 0)")
            
            Text(selectedField ?? "")
        }
        .onAppear {
            let customer = Customer(firstName: "Sameer", lastName: "Nadaf", age: 25, isPremium: true)
            selectedField = customer["firstName"]
        }
    }
}

#Preview {
    SubscriptSwiftUI()
}
