//
//  ExtensionTests.swift
//  shortcut code challenge swiftUITests
//
//  Created by Mohsen on 11/28/21.
//

import XCTest

class ExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testConvertStringToDate() throws {
        let dateFormatter = ISO8601DateFormatter()
        let localObj = dateFormatter.date(from: "1990-02-19T00:00:00+0000")
        
        let convertedDate = Date.convertToDate("1990", "02", "19")
        
        XCTAssertEqual(localObj, convertedDate)
    }
    
    func testConvertYearStringToDate() throws {
        let dateFormatter = ISO8601DateFormatter()
        let localObj = dateFormatter.date(from: "1990-01-01T00:00:00+0000")
        
        let convertedDate = Date.convertToDate("1990")
        
        XCTAssertEqual(localObj, convertedDate)
    }
    
    func testIsNilArray() throws {
        
        let obj = [1,2]
        
        XCTAssertEqual(obj[safe: 2], nil)
    }
   
    func testConvertToLongDate() throws {
        
        var date = Date.convertToDate("1990", "02", "19")
        
        let strLongDate = date!.convertToLongDate()
        
        XCTAssertEqual(strLongDate, "Feb 19,1990")
    }

}
