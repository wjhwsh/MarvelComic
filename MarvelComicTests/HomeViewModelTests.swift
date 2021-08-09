//
//  HomeViewModelTests.swift
//  MarvelComicTests
//
//  Created by Jianhua Wang on 8/8/21.
//

import XCTest
@testable import MarvelComic
class HomeViewModelTests: XCTestCase {

    var homeViewModel: HomeViewModel?
    override func setUpWithError() throws {
        homeViewModel = HomeViewModel()
    }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchComicsLists() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Test async request for fetching lists of comics
        
        var fetchError: Error?
        let expectation = self.expectation(description: "HomeViewModel fetch lists of comics.")
        homeViewModel?.fetchComicList(completion: { (error) in
            fetchError = error
            expectation.fulfill()
        })
        // Wait for expectations for a maximum of 10 seconds.
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
            XCTAssertNil(fetchError)
            XCTAssertNotNil(self.homeViewModel?.comicList?.data?.results, "Fetch data failed")
            XCTAssertEqual(self.homeViewModel?.comicList?.code ?? 0, 200, "Fetch data status code is not equal to 200")
            XCTAssertGreaterThan(self.homeViewModel?.comicList?.data?.results?.count ?? 0, 0, "Return empty data")
        }
    }
    
}
