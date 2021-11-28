//
//  ServiceTest.swift
//  shortcut code challenge swiftUITests
//
//  Created by Mohsen on 11/28/21.
//

import XCTest
import shortcut_code_challenge_swiftUI

class ServiceTest: XCTestCase {

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
    
    func testgenerateCurrentUrl() throws {
        let localUrl = URL(string: "http://xkcd.com/info.0.json")
        
        let generatedUrl = Services.urlGenerator()

        XCTAssertEqual(localUrl, generatedUrl)
    }
    
    func testGenerateSpecificComicUrl() throws {
        let localUrl = URL(string: "http://xkcd.com/100/info.0.json")
        
        let generatedUrl = Services.urlGenerator(with: 100)
//
        XCTAssertEqual(localUrl, generatedUrl)
    }
    
    func testSaveComicOnCoreData() throws {
        
        let localData = ComicModel(num: 11, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        Storage.shared.saveData(with: localData)

        let recordedData = Storage.shared.fetchData(for: 11)

        XCTAssertEqual(localData, recordedData!)
        
    }
    
    func testFetchAllData() throws {
        
        let previousData = Storage.shared.fetchAll()
        
        for item in previousData {
            Storage.shared.removeItem(item.num)
        }
        
        let localData1 = ComicModel(num: 11, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        
        Storage.shared.saveData(with: localData1)

        let localData2 = ComicModel(num: 12, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        
        Storage.shared.saveData(with: localData2)
        
        let localData3 = ComicModel(num: 13, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        
        Storage.shared.saveData(with: localData3)
        
        
        let recordedData = Storage.shared.fetchAll()

        XCTAssertEqual(recordedData.count, 3)
        
        XCTAssertTrue(recordedData.filter({ $0.num == localData1.num}).first != nil)
        
        XCTAssertTrue(recordedData.filter({ $0.num == localData2.num}).first != nil)
        
        XCTAssertTrue(recordedData.filter({ $0.num == localData3.num}).first != nil)
        
    }
    
    func testRemoveData() throws {
        
        let localData1 = ComicModel(num: 11, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        
        Storage.shared.saveData(with: localData1)
        
        Storage.shared.removeItem(localData1.num)
        
        let recordedData = Storage.shared.fetchData(for: localData1.num)
        
        XCTAssertEqual(recordedData, nil)
    }
    
    func testRemoveItemNotExist() throws {
        
        
        Storage.shared.removeItem(11)
        Storage.shared.removeItem(11)
        
        let recordedData = Storage.shared.fetchData(for: 11)
        
        XCTAssertEqual(recordedData, nil)
    }
    
    func testDuplicateSave() throws {
        
        let localData1 = ComicModel(num: 11, description: "comicDescription" , publishedDate:  Date(), link: "Comic Link", image: nil, news: "Comic News", safeTitle: "safe title", title: "title", transcript: "Transcript")
        
        Storage.shared.saveData(with: localData1)
       
        Storage.shared.saveData(with: localData1)
       
        Storage.shared.saveData(with: localData1)
        
        let recordedData = Storage.shared.fetchAll().filter({ $0.num == localData1.num})
        
        XCTAssertEqual(recordedData.count, 1)
    }

}
