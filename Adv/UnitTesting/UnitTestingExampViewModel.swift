//
//  UnitTestingExampViewModel.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/21.
//

import SwiftUI

class UnitTestingExampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
}
