//
//  ServiceTests.swift
//  MarvelComicTests
//
//  Created by Jianhua Wang on 8/8/21.
//

import XCTest
@testable import MarvelComic

class ServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testComicListRequest() throws {
        // Test async request for fetching lists of comics
        var comicListResult: Result<ComicList, Error>?
        let expectation = self.expectation(description: "Request comic list json data.")
        let service = Service()
        service.fetchComicsLists(completionHandler: { (result) in
            comicListResult = result
            expectation.fulfill()
        })
        // Wait for expectations for a maximum of 10 seconds.
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            switch comicListResult {
            case .success(let comicList):
                XCTAssertEqual(comicList.code, 200)
                XCTAssertEqual(comicList.data?.results?.count ?? 20, 20, "Not 20 results returned")
            case .failure,
                 .none:
                XCTFail()
            }
        }
    }
    
    
    func testComicRequest() throws {
        // Test async request for fetching single comic by id
        var comicListResult: Result<ComicList, Error>?
        let expectation = self.expectation(description: "Request comic json data.")
        let service = Service()
        let testComicId = 15808
        service.fetchComic(testComicId, completionHandler: { (result) in
            comicListResult = result
            expectation.fulfill()
        })
        // Wait for expectations for a maximum of 10 seconds.
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            switch comicListResult {
            case .success(let comicList):
                XCTAssertEqual(comicList.code, 200)
                XCTAssertEqual(comicList.data?.results?.first?.id ?? 0, testComicId, "Comic id is not equal to \(testComicId)")
            case .failure,
                 .none:
                XCTFail()
            }
        }
    }
        
        
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
