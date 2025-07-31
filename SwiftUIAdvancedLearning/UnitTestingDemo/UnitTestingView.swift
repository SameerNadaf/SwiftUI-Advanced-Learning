//
//  UnitTestingView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 25/07/25.
//

import SwiftUI

struct UnitTestingView: View {
    
    @StateObject var vm = UnitTestingViewModel(isPremium: false)
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingView()
}
