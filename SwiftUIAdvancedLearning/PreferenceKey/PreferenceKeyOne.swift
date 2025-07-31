//
//  PreferenceKeyOne.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 22/07/25.
//

import SwiftUI

struct PreferenceKeyOne: View {
    
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
            Text("Header Section")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(Color.blue)
            Text("\(rectSize)")
            Spacer()
            HStack {
                Rectangle()
                GeometryReader { geometry in
                    Rectangle()
                        .updateRectangleGeoSize(geometry.size)
                        .overlay {
                            Text("\(geometry.size)")
                                .foregroundStyle(.white)
                        }
                }
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeoSizePreferenceKey.self) { value in
            rectSize = value
        }
    }
}

struct RectangleGeoSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeoSizePreferenceKey.self, value: size)
    }
}

#Preview {
    PreferenceKeyOne()
}
