//
//  CustomTransition.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    
    let rotation: Double
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    
    static var rotating: AnyTransition {
        return AnyTransition
            .modifier(active: RotateViewModifier(rotation: 360),
                      identity: RotateViewModifier(rotation: 0))
    }
    
    static func rorating(rotation: Double) -> AnyTransition {
        return AnyTransition
            .modifier(active: RotateViewModifier(rotation: rotation),
                      identity: RotateViewModifier(rotation: 0))
    }
    
    static var rotateOn: AnyTransition {
        asymmetric(insertion: rotating,
                   removal: .move(edge: .leading))
    }
    
}

struct CustomTransition: View {
    
    @State private var showRectangle: Bool = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if showRectangle {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .transition(AnyTransition.rotating.animation(.easeInOut))
//                    .transition(.rorating(rotation: 1080))
                    .transition(.rotateOn)
            }
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 1)) {
                    showRectangle.toggle()
                }
            } label: {
                Text("Click me")
                    .withDefaultButtonStyle()
                    .padding(.horizontal)
            }
            .withNewButtonStyle()
        }
    }
}

#Preview {
    CustomTransition()
}
