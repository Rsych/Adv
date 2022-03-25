//
//  UnitTestingExampViewModel.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/21.
//

import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void)
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewTestDataService:NewDataServiceProtocol {
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "One", "Two", "Three"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
}

class UnitTestingExampViewModel: ObservableObject {
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    let dataService: NewDataServiceProtocol
    var cancellable = Set<AnyCancellable>()
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol = NewTestDataService(items: nil)) {
        self.isPremium = isPremium
        self.dataService = dataService
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
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { [weak self] returnedItems in
            self?.dataArray = returnedItems
        }
    }
    
    func downloadItemsWithCombine() {
        dataService.downloadItemsWithCombine()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedItems in
                self?.dataArray = returnedItems
            }
            .store(in: &cancellable)
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
}
