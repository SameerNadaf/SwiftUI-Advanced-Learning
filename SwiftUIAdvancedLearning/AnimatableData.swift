//
//  AnimatableData.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI

struct AnimatableData: View {
    
    @State private var animate: Bool = false
    
    var body: some View {
        ZStack {
            PacMan(angle: animate ? 20 : 0)
                .frame(width: 300, height: 300)
            Circle()
                .fill(Color.red)
                .frame(width: 30, height: 30)
                .offset(x: animate ? 30 : 60, y: animate ? -90 : -60)
        }
        .onAppear {
            withAnimation(.easeInOut.repeatForever()) {
                animate.toggle()
            }
        }
    }
}

struct PacMan: Shape {
    
    var angle: Double
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue}
    }
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: angle),
                endAngle: Angle(degrees: 360 - angle),
                clockwise: false)
        }
    }
}

#Preview {
    AnimatableData()
}
