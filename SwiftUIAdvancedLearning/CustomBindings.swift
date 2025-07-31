//
//  CustomBindings.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 28/07/25.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { returnedValue in
            if !returnedValue {
                value.wrappedValue = nil
            }
        }
    }
}

struct CustomBindings: View {
    
    @State var title: String = "Default Title"
    @State private var alertTitle: String? = nil
    
    var body: some View {
        Text(title)
        CustomBindings1(title: $title)
        CustomBindings2(title: $title)
        CustomBindings2(title: Binding(get: {
            return title
        }, set: { newTitle in
            title = newTitle
        }))
        
        Button("Alert") {
            alertTitle = "Alert Title"
        }
        
        .alert(alertTitle ?? "Error", isPresented: Binding(value: $alertTitle)) {
            Button("OK") {
                
            }
        }
    }
}

struct CustomBindings1: View {
    
    @Binding var title: String
    
    var body: some View {
        Text(title)
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    title = "Changed Title"
//                }
//            }
    }
}

struct CustomBindings2: View {
    
    var title: Binding<String>
    
    var body: some View {
        Text(title.wrappedValue)
            .onAppear {
                title.wrappedValue = "changed title 2"
            }
    }
}

#Preview {
    CustomBindings()
}
