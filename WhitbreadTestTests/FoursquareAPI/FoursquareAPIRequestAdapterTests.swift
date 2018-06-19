//
//  FoursquareAPIRequestAdapterTests.swift
//  WhitbreadTestTests
//
//  Created by Radoslav Blasko on 19/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import WhitbreadTest

class FoursquareAPIRequestAdapterTests: XCTestCase {
    func testAdapt() {
        let adapter = FoursquareAPIRequestAdapter(clientID: "a", clientSecret: "b", version: "v")

        let urlStr = "http://abc.com/"
        let request = URLRequest(url: URL(string: urlStr)!)

        guard let result = try? adapter.adapt(request) else {
            XCTFail("Could not adapt request!")
            return
        }

        let expectedResult = "http://abc.com/?client_id=a&client_secret=b&v=v"
        XCTAssertNotNil(result.url)
        XCTAssertEqual(result.url!.absoluteString, expectedResult)
    }
}
