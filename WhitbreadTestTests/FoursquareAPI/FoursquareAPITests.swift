//
//  FoursquareAPITests.swift
//  WhitbreadTestTests
//
//  Created by Radoslav Blasko on 19/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import XCTest
@testable import WhitbreadTest

class FoursquareAPITests: XCTestCase {
    func testDefault() {
        let defaultApi = FoursquareAPI.default
        XCTAssertEqual(defaultApi.adapter.clientID, "12TBMZ5DUFWJD0MID5SGPPBHPJXHUVXRM4BTD3NTZQNDYN2Q")
        XCTAssertEqual(defaultApi.adapter.clientSecret, "BIAQEU3F3Z2AL3M0DVZ2XD0F0N5VKSDCZCXY2V53AHAR1UZC")
        XCTAssertEqual(defaultApi.adapter.version, "20180323")
    }
}
