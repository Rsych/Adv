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
    //    @Published var basicPublisher: String = "first publish"
    //    let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>()
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        //        let items = ["One", "Two", "Three"]
        let items: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        for i in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                //                self.basicPublisher = items[i]
                //                self.currentValuePublisher.send(items[i])
                self.passThroughPublisher.send(items[i])
                
                if (i > 4 && i < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if i == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }
        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
        //            self.passThroughPublisher.send(1)
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        //            self.passThroughPublisher.send(2)
        //        }
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        //            self.passThroughPublisher.send(3)
        //        }
    }
}

class AdvCombineExampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    
    let dataService: AdvCombineDataService
    var cancellable = Set<AnyCancellable>()
    let multiCastPublisher = PassthroughSubject<Int, Error>()
    
    init(dataService: AdvCombineDataService) {
        self.dataService = dataService
        addSubscribers()
    }
    
    private func addSubscribers() {
        //        dataService.passThroughPublisher
        
        // Sequence Operations
        /*
         //            .first()
         //            .first(where: { $0 > 4 })
         //            .tryFirst(where: { int in
         //                if int == 3 {
         //                    throw URLError(.badServerResponse)
         //                }
         //
         //                return int > 1
         //            })
         //            .last()
         //            .last(where: { $0 < 4 })
         //            .tryLast(where: { int in
         //                if int == 3 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int > 1
         //            })
         //            .dropFirst()
         //            .dropFirst(3)
         //            .drop(while: { $0 < 5})
         //            .tryDrop(while: { int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int < 6
         //            })
         //            .prefix(4)
         //            .prefix(while: { $0 < 5 })
         //            .tryPrefix(while: <#T##(Int) throws -> Bool#>)
         //            .output(at: 4)
         //            .output(in: 2..<4)
         */
        
        // Mathematic Operations
        /*
         //            .max()
         //            .max(by: { int1, int2 in
         //                return int1 < int2
         //            })
         //            .max(by: { $0 < $1 })
         //            .tryMax(by: )
         //            .min()
         //            .tryMin(by: )
         */
        
        // Filter / Reducing Operations
        /*
         //            .map({ String($0) })
         //            .tryMap({ int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return String(int)
         //            })
         //            .compactMap({ int in
         //                if int == 5 {
         //                    return nil
         //                }
         //                return String(int)
         //            })
         //            .tryCompactMap(<#T##transform: (Int) throws -> T?##(Int) throws -> T?#>)
         
         //            .filter({ ($0 > 3) && ($0 < 7) })
         //            .tryFilter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)
         //            .removeDuplicates() // It has to be duplicates back to back like 4, 4. Not gonna work 4, 5, 4
         //            .removeDuplicates(by: { int1, int2 in
         //                return int1 == int2
         //            })
         //            .tryRemoveDuplicates(by: <#T##(Int, Int) throws -> Bool#>)
         //            .replaceNil(with: 5)
         //            .replaceEmpty(with: [])
         //            .replaceError(with: "Default Value")
         //            .scan(0, { existingValue, newValue in
         //                return existingValue + newValue
         //            })
         //            .scan(0) { $0 + $1 }
         //            .scan(0, +)
         //            .tryScan(<#T##initialResult: T##T#>, <#T##nextPartialResult: (T, Int) throws -> T##(T, Int) throws -> T#>)
         
         //            .reduce(0, { existingValue, newValue in
         //                return existingValue + newValue
         //            }) // print 55
         //            .map({ String($0) })
         //            .collect() // collects and publish at once, instead having loading, shows at once
         //            .collect(3) // collects and publish at batch of 3
         //            .allSatisfy({ $0 < 50 })
         //            .tryAllSatisfy(<#T##predicate: (Int) throws -> Bool##(Int) throws -> Bool#>)
         */
        
        // Timing Operations
        /*
         //            .debounce(for: 0.75, scheduler: DispatchQueue.main) // waits for 0.75 to see if there's publish, useful for textfield
         //            .delay(for: 2, scheduler: DispatchQueue.main)
         //            .measureInterval(using: DispatchQueue.main)
         //            .map({ stride in
         //                return "\(stride.timeInterval)"
         //            })
         //            .throttle(for: 3, scheduler: DispatchQueue.main, latest: true) // wait for some seconds and show latest or first
         //            .retry(3)
         .timeout(0.75, scheduler: DispatchQueue.main) // terminates publish if time interval is more than 0.75
         */
        
        // Multiple Publishers / Subscribers
        /*
         //            .combineLatest(dataService.boolPublisher, dataService.intPublisher)
         //            .compactMap({ (int, bool) in
         //                if bool {
         //                    return String(int)
         //                }
         //                return nil
         //            })
         //            .compactMap({ $1 ? String($0) : "nil" })
         //            .compactMap({ (int1, bool, int2) in
         //                if bool {
         //                    return String(int1)
         //                }
         //                return "n/a"
         //            })
         //            .merge(with: dataService.intPublisher)
         //            .zip(dataService.boolPublisher, dataService.intPublisher)
         //            .map({ tuple in
         //                return String(tuple.0) + tuple.1.description + String(tuple.2)
         //            })
         
         //            .tryMap({ int in
         //                if int == 5 {
         //                    throw URLError(.badServerResponse)
         //                }
         //                return int
         //            })
         //            .catch({ error in
         //                return self.dataService.intPublisher
         //            })
         */
        
        let sharedPublisher = dataService.passThroughPublisher
//            .dropFirst(3)
            .share()
//            .multicast {
//                PassthroughSubject<Int, Error>()
//            }
            .multicast(subject: multiCastPublisher)
        
//        dataService.passThroughPublisher
        sharedPublisher
            .map({ String($0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error)"
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedValue in
                //                self?.data = returnedValue
                //                self?.data.append(contentsOf: returnedValue)
                self?.data.append(returnedValue)
            }
            .store(in: &cancellable)
        
//        dataService.passThroughPublisher
        sharedPublisher
            .map({ $0 > 5 ? true : false })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "Error: \(error)"
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] returnedValue in
                //                self?.data = returnedValue
                //                self?.data.append(contentsOf: returnedValue)
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellable)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sharedPublisher
                .connect()
                .store(in: &self.cancellable)
        }
    }
    
}

struct AdvCombineExamp: View {
    @StateObject private var vm: AdvCombineExampViewModel
    init(dataService: AdvCombineDataService) {
        _vm = StateObject(wrappedValue: AdvCombineExampViewModel(dataService: dataService))
    }
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) { item in
                        Text(item)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
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
