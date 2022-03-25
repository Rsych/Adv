//
//  NewTestDataService_Tests.swift
//  Adv_Tests
//
//  Created by Ryan J. W. Kim on 2022/03/25.
//

import XCTest
@testable import Adv
import Combine

class NewTestDataService_Tests: XCTestCase {
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellable.removeAll()
    }
    
    func test_NewTestDataService_init_doesSetValuesCorrectly() {
        // Given
        let items: [String]? = nil
        let items2: [String]? = []
        let items3: [String]? = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        
        // When
        let dataService = NewTestDataService(items: items)
        let dataService2 = NewTestDataService(items: items2)
        let dataService3 = NewTestDataService(items: items3)
        // THen
        XCTAssertFalse(dataService.items.isEmpty)
        XCTAssertTrue(dataService2.items.isEmpty)
        XCTAssertEqual(dataService3.items.count, items3?.count)
    }
    
    func test_NewTestDataService_downloadItemsWithEscaping_ReturnValues() {
        // Given
        let dataService = NewTestDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithEscaping { returnedItems in
            items = returnedItems
            expectation.fulfill()
        }
        // THen
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewTestDataService_downloadItemsWithCombine_ReturnValues() {
        // Given
        let dataService = NewTestDataService(items: nil)
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellable)
        
        // THen
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    
    func test_NewTestDataService_downloadItemsWithCombine_Fail() {
        // Given
        let dataService = NewTestDataService(items: [])
        
        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    
                    let urlError = error as? URLError
                    XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if urlError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellable)
        
        // THen
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
