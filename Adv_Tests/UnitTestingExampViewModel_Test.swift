//
//  UnitTestingExampViewModel_Test.swift
//  Adv_Tests
//
//  Created by Ryan J. W. Kim on 2022/03/21.
//

import XCTest
@testable import Adv

// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

class UnitTestingExampViewModel_Test: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingExampViewModel_dataArray_shouldAddItems() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        
        for _ in 0..<loopCount {
            // Better use random string instead uuidString
            vm.addItem(item: UUID().uuidString)
        }
        XCTAssertEqual(vm.dataArray.count, loopCount)
    }
    
    func test_UnitTestingExampViewModel_dataArray_shouldNotAddBlankString() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        vm.addItem(item: "")
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldStartNil() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldBeNilWhenSelectingInvalidItem() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        // Select valid item
        let newItem = UUID().uuidString
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        
        // Select invalid item
        vm.selectedItem(item: UUID().uuidString)
        
        XCTAssertNil(vm.selectedItem)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldBeSelected() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        let newItem = UUID().uuidString
        
        vm.addItem(item: newItem)
        vm.selectedItem(item: newItem)
        
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, newItem)
    }
    
    func test_UnitTestingExampViewModel_selectedItem_shouldBeSelected_stress() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        let loopCount: Int = Int.random(in: 1..<100)
        var itemsArray: [String] = []
        
        for _ in 0..<loopCount {
            let newItem = UUID().uuidString
            vm.addItem(item: newItem)
            itemsArray.append(newItem)
        }
        
        let randomItem = itemsArray.randomElement() ?? ""
        vm.selectedItem(item: randomItem)
        
        XCTAssertNotNil(vm.selectedItem)
        XCTAssertEqual(vm.selectedItem, randomItem)
    }
    
    func test_UnitTestingExampViewModel_saveItem_shouldThrowError_noData() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString))
        
        XCTAssertThrowsError(try vm.saveItem(item: UUID().uuidString), "Should throw Item Not Found error!") { error in
            let returnedError = error as? UnitTestingExampViewModel.DataError
            XCTAssertEqual(returnedError, UnitTestingExampViewModel.DataError.itemNotFound)
        }
    }
}
