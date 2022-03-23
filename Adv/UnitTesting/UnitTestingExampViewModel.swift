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
    @Published var selectedItem: String? = nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectedItem(item: String) {
        if let i = dataArray.first(where: { $0 == item }) {
            selectedItem = i
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else { throw DataError.noData }
        
        if let i = dataArray.first(where: { $0 == item }) {
            print("Save item! \(i)")
        } else {
            throw DataError.itemNotFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
}
