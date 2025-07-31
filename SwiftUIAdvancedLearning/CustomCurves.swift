//
//  CustomCurves.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI



struct CustomCurves: View {
    
    var body: some View {
        ZStack {
            QuadSample()
                .foregroundStyle(
                    LinearGradient(colors: [Color.red, Color.blue], startPoint: .leading, endPoint: .trailing)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
}

struct ArcSample: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: 100,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: -90),
                clockwise: true)
        }
    }
}

struct ShapeWithArc: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 180),
                clockwise: false)
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
    }
}

struct Capsule: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            
            let gap = rect.width / 4
            
            path.move(to: CGPoint(x: rect.minX + gap, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - gap, y: rect.minY))
            path.addArc(
                center: CGPoint(x: rect.maxX - gap, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 90),
                clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - gap, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + gap, y: rect.maxY))
            path.addArc(
                center: CGPoint(x: rect.minX + gap, y: rect.midY),
                radius: rect.height / 2,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: -90),
                clockwise: false)
        }
    }
}

struct QuadSample: Shape {
    nonisolated func path(in rect: CGRect) -> Path {
        Path { path in
            let midX = rect.midX
            let minX = rect.minX
            let maxX = rect.maxX
            let midY = rect.midY
            let minY = rect.minY
            let maxY = rect.maxY
            
            path.move(to: CGPoint(x: minX, y: midY))
            path.addQuadCurve(to: CGPoint(x: midX, y: midY),
                              control: CGPoint(x: rect.width * 0.25, y: rect.height * 0.25))
            path.addQuadCurve(to: CGPoint(x: maxX, y: midY),
                              control: CGPoint(x: rect.width * 0.75, y: rect.height * 0.75))
            path.addLine(to: CGPoint(x: maxX, y: maxY))
            path.addLine(to: CGPoint(x: minX, y: maxY))
            path.addLine(to: CGPoint(x: minX, y: midY))
            
        }
    }
}

#Preview {
    CustomCurves()
}
