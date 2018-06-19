//
//  VenueSearchModelTests.swift
//  WhitbreadTestTests
//
//  Created by Radoslav Blasko on 19/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import WhitbreadTest
import OHHTTPStubs

class VenueSearchModelTests: XCTestCase {
    private let api = FoursquareAPI.default

    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }

    func testSearchSuccess() {
        stub(condition: isHost("api.foursquare.com") && isPath("/v2/venues/search")) { (request) -> OHHTTPStubsResponse in
            let stubPath = OHPathForFile("venues.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }

        let model = VenueSearchModel(api: api)
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "venues", withExtension: "json")!)
        let json = String(data: data, encoding: .utf8)!
        let expectedResult = try! FoursquareAPI.Response.Venues(JSONString: json)

        let expectation = self.expectation(description: "Wait for HTTP response")

        model.onSearchFinished = { result in
            expectation.fulfill()
        }

        model.searchTerm = "a"
        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(expectedResult.venues, model.items)
    }

    func testSearchFailed() {
        let expectedError = NSError(domain: NSURLErrorDomain, code: 1, userInfo: nil)

        stub(condition: isHost("api.foursquare.com") && isPath("/v2/venues/search")) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(error: expectedError)
        }

        let expectation = self.expectation(description: "Wait for HTTP response")

        let model = VenueSearchModel(api: api)
        model.onSearchFinished = { result in
            switch result {
            case .error(let e as NSError):
                XCTAssertNotNil(e)
                XCTAssertEqual(expectedError, e)
            default:
                XCTFail("Expected error not returned!")
            }

            expectation.fulfill()
        }

        model.searchTerm = "a"
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(model.items.count, 0)
    }

    func testSearchWithNilDoesNotSendRequest() {
        var requestSent = false
        stub(condition: isHost("api.foursquare.com") && isPath("/v2/venues/search")) { (request) -> OHHTTPStubsResponse in
            requestSent = true
            return OHHTTPStubsResponse(error: NSError(domain: NSURLErrorDomain, code: 1, userInfo: nil))
        }

        let expectation = self.expectation(description: "Wait for HTTP response")

        let model = VenueSearchModel(api: api)
        model.onSearchFinished = { result in
            expectation.fulfill()
        }

        model.searchTerm =  nil
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(requestSent)
    }
}
