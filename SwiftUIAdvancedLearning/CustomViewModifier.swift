//
//  CustomViewModifier.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI

struct DefaultButtonStyle: ViewModifier {
    
    let color: Color
    let font: Font
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(color)
            .cornerRadius(10)
    }
}

extension View {
    func withDefaultButtonStyle(color: Color = .blue, font: Font = .headline) -> some View {
        self.modifier(DefaultButtonStyle(color: color, font: font))
    }
}

struct CustomViewModifier: View {
    var body: some View {
        VStack {
            Text("Button".uppercased())
                .modifier(DefaultButtonStyle(color: .red, font: .caption))
            
            Text("Button".uppercased())
                .withDefaultButtonStyle(font: .title)
            
            Text("Button".uppercased())
                .withDefaultButtonStyle(color: .green, font: .title3)
        }
        .padding()
    }
}

#Preview {
    CustomViewModifier()
}
