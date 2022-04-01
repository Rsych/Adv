//
//  FuturesCombineExamp.swift
//  Adv
//
//  Created by Ryan J. W. Kim on 2022/03/29.
//

import SwiftUI
import Combine

// Download with combine
// Download with @escaping closure
// convert @escaping closure to combine

class FuturesCombineViewModel: ObservableObject {
    @Published var title: String = "Starting title"
    let url = URL(string: "https://www.google.com")!
    var cancellable = Set<AnyCancellable>()
    
    init() {
        download()
    }
    
    func download() {
//        getCombinePublisher()
//            .sink { _ in
//
//            } receiveValue: { [weak self] returnedValue in
//                self?.title = returnedValue
//            }
//            .store(in: &cancellable)
        
        getEscapingClosure { [weak self] returnedValue, error in
            self?.title = returnedValue
        }
    }
    
    func getCombinePublisher() -> AnyPublisher<String, URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("New value 2", nil)
        }
        .resume()
    }
}

struct FuturesCombineExamp: View {
    @StateObject private var vm = FuturesCombineViewModel()
    var body: some View {
        Text(vm.title)
    }
}

struct FuturesCombineExamp_Previews: PreviewProvider {
    static var previews: some View {
        FuturesCombineExamp()
    }
}
