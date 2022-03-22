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
        
        vm.addItem(item: "Hello")
        
        XCTAssertFalse(vm.dataArray.isEmpty)
    }
    
    func test_UnitTestingExampViewModel_dataArray_shouldNotAddBlankString() {
        
        let vm = UnitTestingExampViewModel(isPremium: Bool.random())
        
        vm.addItem(item: "")
        
        XCTAssertTrue(vm.dataArray.isEmpty)
    }
}
