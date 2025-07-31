//
//  CustomShapes.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 20/07/25.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct Diamond: Shape {
    
    nonisolated func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            let gap: CGFloat = rect.width * 0.28
            
            path.move(to: CGPoint(x: rect.minX + gap, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - gap, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + gap))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - gap))
            path.addLine(to: CGPoint(x: rect.maxX - gap, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + gap , y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - gap))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + gap))
        }
    }
}

struct CustomShapes: View {
    var body: some View {
        Diamond()
            .frame(width: 200, height: 200)
    }
}

#Preview {
    CustomShapes()
}
