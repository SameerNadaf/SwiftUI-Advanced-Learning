//
//  ScrollOffsetPreferenceKey.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 22/07/25.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: View {
    
    private let title: String = "Preference Key"
    @State private var offset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
               titleArea
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .scrollOffsetChange(geo.frame(in: .global).minY)
                        }
                    )
                
                contentArea
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .overlay(alignment: .top) { overlay }
        .onPreferenceChange(ScrollOffsetPreferenceChange.self) { value in
            offset = value
        }
        .overlay {
            Text("\(offset)")
        }
    }
}

extension ScrollOffsetPreferenceKey {
    private var titleArea: some View {
        Text(title)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
    }
    
    private var contentArea: some View {
        ForEach(0..<20, id: \.self) { index in
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(Color.pink.opacity(0.7))
                .frame(maxWidth: .infinity)
                .frame(height: 200)
        }
    }
    
    private var overlay: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(Material.ultraThin)
    }
}

struct ScrollOffsetPreferenceChange: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    func scrollOffsetChange(_ offset: CGFloat) -> some View {
        preference(key: ScrollOffsetPreferenceChange.self, value: offset)
    }
}

#Preview {
    ScrollOffsetPreferenceKey()
}
