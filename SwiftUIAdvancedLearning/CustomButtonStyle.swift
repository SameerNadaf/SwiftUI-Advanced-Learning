//
//  CustomButtonStyle.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI

struct NewButtonStyle: ButtonStyle {
    
    let opacity: Double
    let scaleEffect: CGFloat
    
    init(opacity: Double, scaleEffect: CGFloat) {
        self.opacity = opacity
        self.scaleEffect = scaleEffect
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? opacity : 1.0)
            .scaleEffect(configuration.isPressed ? scaleEffect : 1.0)
    }
}

extension View {
    
    /// This function returns button style with optional parameters
    func withNewButtonStyle(opacity: Double = 0.9, scaleEffect: CGFloat = 0.9) -> some View {
        buttonStyle(NewButtonStyle(opacity: opacity, scaleEffect: scaleEffect))
    }
}

struct CustomButtonStyle: View {
    var body: some View {
        ZStack{
            Button {
                
            } label: {
                Text("Custom Button Style")
                    .withDefaultButtonStyle(color: .green, font: .headline)
                    .padding()
            }
//            .buttonStyle(NewButtonStyle(opacity: 0.5, scaleEffect: 0.5))
            .withNewButtonStyle()
        }
    }
}

#Preview {
    CustomButtonStyle()
}
