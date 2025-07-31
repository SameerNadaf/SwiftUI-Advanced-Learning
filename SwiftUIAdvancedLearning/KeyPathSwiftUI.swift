//
//  KeyPathSwiftUI.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 31/07/25.
//

import SwiftUI

struct MyDataModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

extension Array {
    func sortedByKeypath<T: Comparable>(_ keypath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            if ascending {
                return item1[keyPath: keypath] < item2[keyPath: keypath]
            }
            else  {
                return item1[keyPath: keypath] > item2[keyPath: keypath]
            }
        }
    }
    
    mutating func sortByKeypath<T: Comparable>(_ keypath: KeyPath<Element, T>, ascending: Bool = true) {
        self.sort { item1, item2 in
            if ascending {
                return item1[keyPath: keypath] < item2[keyPath: keypath]
            }
            else  {
                return item1[keyPath: keypath] > item2[keyPath: keypath]
            }
        }
    }
}

struct KeyPathSwiftUI: View {
    
    @AppStorage("user_count") var userCount: Int = 0
    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(dataArray) { data in
                    VStack(alignment: .leading) {
                        Text("\(data.title)")
                        Text("\(data.count)")
                        Text("\(data.date, style: .date)")
                    }
                }
            }
            .listStyle(.insetGrouped)
            .onAppear {
                let array = [
                    MyDataModel(title: "Item one", count: 2, date: .now),
                    MyDataModel(title: "Item two", count: 5, date: .now),
                    MyDataModel(title: "Item three", count: 1, date: .now),
                    MyDataModel(title: "Item four", count: 4, date: .now),
                    MyDataModel(title: "Item five", count: 3, date: .now)
                ]
                
//                let sortedArray = array.sortedByKeypath(\.count, ascending: false)
                dataArray = array
                dataArray.sortByKeypath(\.count, ascending: false)
                
            }
            
            .navigationTitle("KeyPath")
        }
    }
}

#Preview {
    KeyPathSwiftUI()
}
