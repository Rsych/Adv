//
//  UnitTestingExampViewModel.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/21.
//

import SwiftUI

class UnitTestingExampViewModel: ObservableObject {
    @Published var isPremium: Bool
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
