//
//  FoursquareAPIRequestAdapter.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import Foundation
import Alamofire

class FoursquareAPIRequestAdapter: RequestAdapter {
    private let clientID: String
    private let clientSecret: String
    private let version: String

    init(clientID: String, clientSecret: String, version: String) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.version = version
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let params: Parameters = ["client_id": clientID,
                                  "client_secret": clientSecret,
                                  "v": version]

        do {
            return try URLEncoding.queryString.encode(urlRequest, with: params)
        } catch {
            assertionFailure("Could not inject client_id and/or client_secret and/or version! Request: \(urlRequest)")
            return urlRequest
        }
    }
}
