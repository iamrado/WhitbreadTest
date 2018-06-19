//
//  FoursquareAPIRouterTests.swift
//  WhitbreadTestTests
//
//  Created by Radoslav Blasko on 19/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import WhitbreadTest

class FoursquareAPIRouterTests: XCTestCase {
    func testBaseURL() {
        XCTAssertEqual(FoursquareAPI.Router.baseURL, URL(string: "https://api.foursquare.com/v2/"))
    }

    func testEndpointVenuesSearchComposition() {
        let request = try? FoursquareAPI.Router.venuesSearch(query: "query", limit: 10).asURLRequest()
        XCTAssertNotNil(request)
        XCTAssertNotNil(request!.url)
        XCTAssertEqual(request!.url!, URL(string: "https://api.foursquare.com/v2/venues/search?intent=global&limit=10&query=query"))
    }
}
