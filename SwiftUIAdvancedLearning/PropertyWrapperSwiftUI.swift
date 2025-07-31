//
//  PropertyWrapperSwiftUI.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 31/07/25.
//

import SwiftUI

@propertyWrapper
struct CapitalizedString: DynamicProperty {
    @State var value: String
    
    var wrappedValue: String {
        get { value }
        nonmutating set {
            value = newValue.capitalized
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

struct PropertyWrapperSwiftUI: View {
    
    @CapitalizedString private var title: String = "Hello, world!"
    
    var body: some View {
        Text(title)
        
        Button("Change Text") {
            title = "swiftUI is amazing!"
        }
    }
}

#Preview {
    PropertyWrapperSwiftUI()
}
