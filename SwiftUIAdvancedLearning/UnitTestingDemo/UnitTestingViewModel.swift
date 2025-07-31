//
//  UnitTestingViewModel.swift
//  SwiftUIAdvancedLearning
//
//  Created by Sameer  on 25/07/25.
//

import Foundation

class UnitTestingViewModel: ObservableObject {
//    @Published var text: String
    @Published var isPremium: Bool
    
    init(isPremium: Bool) {
//        self.text = text
        self.isPremium = isPremium
    }
}
