//
//  AdvCombineExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/25.
//

import SwiftUI
import Combine

class AdvCombineDataService {
//    @Published var basicPublisher: [String] = []
    @Published var basicPublisher: String = ""
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items = ["One", "Two", "Three"]
        
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.basicPublisher = items[i]
            }
        }
    }
}

class AdvCombineExampViewModel: ObservableObject {
    @Published var data: [String] = []
    
    let dataService: AdvCombineDataService
    var cancellable = Set<AnyCancellable>()
    
    init(dataService: AdvCombineDataService) {
        self.dataService = dataService
        addSubscribers()
    }
    
    private func addSubscribers() {
        dataService.$basicPublisher
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellable)
    }
    
}

struct AdvCombineExamp: View {
    @StateObject private var vm: AdvCombineExampViewModel
    init(dataService: AdvCombineDataService) {
        _vm = StateObject(wrappedValue: AdvCombineExampViewModel(dataService: dataService))
    }
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.data, id: \.self) { item in
                    Text(item)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

struct AdvCombineExamp_Previews: PreviewProvider {
    static let dataService =  AdvCombineDataService()
    static var previews: some View {
        AdvCombineExamp(dataService: dataService)
    }
}
