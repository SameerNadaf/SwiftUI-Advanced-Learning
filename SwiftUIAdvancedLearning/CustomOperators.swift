//
//  CustomOperators.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 31/07/25.
//

import SwiftUI

struct CustomOperators: View {
    var body: some View {
        let result = 15 -/ 5
        Text("\(result.formatted())")
    }
}

infix operator +/
infix operator -/

extension FloatingPoint {
    static func +/ (lhs: Self, rhs: Self) -> Self {
        (lhs + rhs) / 2
    }
    
    static func -/ (lhs: Self, rhs: Self) -> Self {
        (lhs - rhs) / 2
    }
}

#Preview {
    CustomOperators()
}
