//
//  BooksServiceTests.swift
//  BooksServiceTests
//
//  Created by Majit Uteniyazov on 31/07/21.
//

import XCTest
@testable import BooksTestApp

class BooksServiceTests: XCTestCase {
    
    var bookService: BookSearchServiceProtocol!
    
    override func setUp() {
        super.setUp()
        bookService = BookSearchService()
    }
    
    override func tearDown() {
        bookService = nil
        super.tearDown()
    }
    
    func testIsServiceAvailable() throws {
        let expectation = expectation(description: "Perhaps there is no network connection Expectation")
//        let query = "Что то сильно на русском что гугл не может распознать"
        let query = "programming"
        var isSuccess: Bool!
        
        XCTAssertNoThrow(
            bookService.getBooks(with: query, result: { result in
                switch result {
                case .success(let books):
                    isSuccess = books.count > 0
                    XCTAssertNotNil(isSuccess)
                    XCTAssertTrue(isSuccess)
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                }
            })
        )
        
        waitForExpectations(timeout: 3, handler: nil)
    }

}
