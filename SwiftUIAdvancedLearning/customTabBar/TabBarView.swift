//
//  TabBarView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 22/07/25.
//

import SwiftUI

struct TabBarView: View {
    
    
    
    var body: some View {
        NavigationStack {
            TabView {
                Tab("Home", image: "house") {
                    Color.red
                }
                Tab("Profile", image: "user") {
                    Color.green
                }
                Tab("Settings", image: "gear") {
                    Color.blue
                }
            }
        }
    }
}

#Preview {
    TabBarView()
}
