//
//  UnitTestingExampViewModel_Test.swift
//  Adv_Tests
//
//  Created by Ryan J. W. Kim on 2022/03/21.
//

import XCTest
import Combine
@testable import Adv

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

class UnitTestingExampViewModel_Test: XCTestCase {
    
    var viewModel: UnitTestingExampViewModel?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = UnitTestingExampViewModel(isPremium: Bool.random())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_UnitTestingExampViewModel_isPremium_shouldBeTrue() {
        // Given
        let userIsPremium: Bool = true
        // When
        let vm = UnitTestingExampViewModel(isPremium: userIsPremium)
        // Then
        XCTAssertTrue(vm.isPremium, "It should be true")
    }
    
    func test_UnitTestingExampViewModel_isPremium_shouldBeInjectedValue() {
        let userIsPremium: Bool = Bool.random()
        let vm = UnitTestingExampViewModel(isPremium: userIsPremium)
        
        XCTAssertEqual(vm.isPremium, userIsPremium)
    }
    
    func test_UnitTestingExampViewModel_isPremium_shouldBeInjectedValue_stress() {
        for _ in 0..<100 {
            let userIsPremium: Bool = Bool.random()
            let vm = UnitTestingExampViewModel(isPremium: userIsPremium)
            
            XCTAssertEqual(vm.isPremium, userIsPremium)
        }
    }
    
    func test_UnitTestingExampViewModel_dataArray_shouldBeEmpty() {
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingExampViewModel_dataArray_shouldAddItems() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            // Better use random string instead uuidString
            vm.addItem(item: UUID().uuidString)
        }
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func test_UnitTestingExampViewModel_dataArray_shouldNotAddBlankString() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        vm.addItem(item: "")
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldStartNil() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        // Select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        
        // Select invalid item
        vm.selectedItem(item: UUID().uuidString)
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldBeSelected() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let newItem = UUID().uuidString
        
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldBeSelected_stress() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        vm.selectedItem(item: randomItem)
        
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingExampViewModel_saveItem_shouldThrowError_noData() {
        
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw Item Not Found error!") { error in
            let returnedError = error as? UnitTestingExampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingExampViewModel.DataError.itemNotFound)
        }
    }
    
    func test_UnitTestingExampViewModel_saveItem_shouldThrowError_noDataArray() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        let loopCount = Int.random(in: 1..<100)
        for _ in 0..<loopCount {
            vm.addItem(item: UUID().uuidString)
        }
        
        do {
            try vm.saveItem(item: "")
        } catch let error {
            let returnedError = error as? UnitTestingExampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingExampViewModel.DataError.noData)
        }
    }
    
    func test_UnitTestingExampViewModel_saveItem_shouldSaveItem() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        let randomItem = itemsArray.randomElement() ?? ""
        XCTAssertFalse(randomItem.isEmpty)
        
        XCTAssertNoThrow(try vm.saveItem(item: randomItem))
        
        do {
            try vm.saveItem(item: randomItem)
        } catch {
            XCTFail()
        }
    }
    
    func test_UnitTestingExampViewModel_downloadWithEscaping_shouldReturnItems() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        let expectation = XCTestExpectation(description: "Should return items after 3seconds.")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadWithEscaping()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingExampViewModel_downloadWithCombine_shouldReturnItems() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        let expectation = XCTestExpectation(description: "Should return items after 3seconds.")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadItemsWithCombine()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_UnitTestingExampViewModel_downloadWithCombine_shouldReturnItems2() {
        
        let items = [UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString, UUID().uuidString]
        let dataService: NewDataServiceProtocol = NewTestDataService(items: items)
        let vm = UnitTestingExampViewModel(isPremium: Bool.random(), dataService: dataService)
        
        let expectation = XCTestExpectation(description: "Should return items after 3seconds.")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        vm.downloadItemsWithCombine()
        
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
        XCTAssertEqual(vm.dataArray.count, items.count)
    }
}
