//
//  DependencyInjectionExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/20.
//

import SwiftUI
import Combine

// Problems with Singletons
// 1. Singleton's are global
// 2. Can't customize the init
// 3. Can't swap out dependencies

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {
//    static let instance = ProductionDataService() // Singleton
    
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class TestDataService: DataServiceProtocol {
    let testData: [PostsModel]
    
    init(data: [PostsModel]?) {
        self.testData = data ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 3, title: "Two", body: "two"),
            PostsModel(userId: 2, id: 3, title: "Three", body: "three")
        ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap( { $0 })
            .eraseToAnyPublisher()
    }
}

//class Dependencies {
//    let dataService: DataServiceProtocol
//
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
//}

class DependencyInjectionViewModel: ObservableObject {
    @Published var dataArray = [PostsModel]()
    var cancellable = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellable)

    }
}

struct DependencyInjectionExamp: View {
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            ForEach(vm.dataArray) { post in
                Text(post.title)
            }
        }
    }
}

struct DependencyInjectionExamp_Previews: PreviewProvider {
//    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
//    static let dataService = TestDataService(data: nil)
    static let dataService = TestDataService(data: [
        PostsModel(userId: 123, id: 123, title: "Test", body: "Test")
    ])
    
    static var previews: some View {
        DependencyInjectionExamp(dataService: dataService)
    }
}
