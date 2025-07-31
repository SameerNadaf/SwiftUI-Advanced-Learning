//
//  ViewBuilders.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 21/07/25.
//

import SwiftUI

struct HeaderViewGeneric<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            content
        }
        .padding(.horizontal)
    }
}

struct ViewBuilders: View {
    var body: some View {

        HeaderViewGeneric(title: "Title") {
            HStack {
                Image(systemName: "plus")
                Text("Add")
            }
        }
    }
}

struct ViewBuilders2: View {
    
    enum ViewType {
        case one, two, three
    }
    
    let type: ViewType
    
    var body: some View {
        Text("Hello, Everyone!")
        typeView
    }
    
    @ViewBuilder private var typeView: some View {
        if type == .one {
            Text("One")
        } else if type == .two{
            Text("Two")
        } else if type == .three {
            Text("Three")
        }
    }
    
}

#Preview {
    ViewBuilders2(type: .three)
}
