//
//  MD5HashTestCase.swift
//  MarvelComicTests
//
//  Created by Jianhua Wang on 8/8/21.
//

import XCTest
@testable import MarvelComic

class MD5HashTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMD5Hash() throws {
        XCTAssertEqual(md5(string: "Hello"), "8b1a9953c4611296a827abf8c47804d7")
      
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
