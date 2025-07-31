//
//  MatchedGeometryEffect.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI

struct MatchedGeometryEffect: View {
    
    @State private var showShape: Bool = false
    @Namespace private var namespace
    
    var body: some View {
        VStack {
            if !showShape {
                RoundedRectangle(cornerRadius: 20)
                    .matchedGeometryEffect(id: "Rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                    .overlay(content: {
                        Text("Tap me")
                            .foregroundStyle(.white)
                    })
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showShape.toggle()
                        }
                    }
            }
            
            Spacer()
            
            if showShape {
                RoundedRectangle(cornerRadius: 20)
                    .matchedGeometryEffect(id: "Rectangle", in: namespace)
                    .frame(width: 100, height: 100)
                    .overlay(content: {
                        Text("Tap me")
                            .foregroundStyle(.white)
                    })
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showShape.toggle()
                        }
                    }
            }
                
        }
    }
}

struct MatchedGeometryEffect2: View {
    
    private let items: [String] = ["Apple", "Banana", "Orange", "Mango"]
    @State private var selectedItem: String = "Apple"
    @Namespace private var namespace
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(items, id: \.self) { item in
                ZStack {
                    if selectedItem == item {
                        Rectangle()
                            .matchedGeometryEffect(id: "background", in: namespace)
                            .frame(width: 50, height: 2)
                            .foregroundStyle(Color.red)
                            .offset(y: 20)
                    }
                    
                    Text(item)
                        .font(.title3)
                        .foregroundStyle(selectedItem == item ? .red : .primary)
                }
                .frame(maxWidth: .infinity)
                .onTapGesture {
                    withAnimation(.linear) {
                        selectedItem = item
                    }
                }
            }
        }
    }
}

#Preview {
    MatchedGeometryEffect2()
}
