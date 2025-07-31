//
//  TimelineViewSwiftUI.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 28/07/25.
//

import SwiftUI

struct TimelineViewSwiftUI: View {
    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                Text("\(context.date)")
                
                let seconds = Calendar.current.component(.second, from: context.date)
                
                Text("\(seconds)")
                
                Rectangle()
                    .frame(
                        width: seconds < 10 ? 100 : seconds < 30 ? 200 : 300,
                        height: 100
                    )
                    .animation(.bouncy, value: seconds)
            }
        }
    }
}

#Preview {
    TimelineViewSwiftUI()
}
