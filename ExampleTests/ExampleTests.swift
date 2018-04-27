//
//  ExampleTests.swift
//  ExampleTests
//
//  Created by Chris Ballinger on 4/27/18.
//

import XCTest
@testable import Example

class ExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let text = "asdf"
        let message = Message(text: text)
        XCTAssertEqual(text, message.name)
    }
}
