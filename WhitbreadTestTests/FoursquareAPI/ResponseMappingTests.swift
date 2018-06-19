//
//  ResponseMappingTests.swift
//  WhitbreadTestTests
//
//  Created by Radoslav Blasko on 19/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import WhitbreadTest

class ResponseMappingTests: XCTestCase {
    func testMapValidVenue() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "venues", withExtension: "json") else {
            XCTFail("Missing file: venues.json")
            return
        }

        let data = try! Data(contentsOf: url)
        let json = String(data: data, encoding: .utf8)!

        guard let response = try? FoursquareAPI.Response.Venues(JSONString: json) else {
            XCTAssert(false, "Could not map JSON!")
            return
        }

        XCTAssertEqual(response.venues.count, 1)

        let venue = response.venues.first!
        XCTAssertEqual(venue.name, "Mr. Purple")
        XCTAssertNotNil(venue.location.address)
        XCTAssertEqual(venue.location.address!, "180 Orchard St")
    }
}
