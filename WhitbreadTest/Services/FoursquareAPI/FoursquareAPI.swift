//
//  FoursquareAPIRouter.swift
//  RevolutTest
//
//  Created by Radoslav Blasko on 25/05/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import Foundation
import Alamofire

class FoursquareAPI {
    let sessionManager: SessionManager
    var adapter: FoursquareAPIRequestAdapter { return sessionManager.adapter as! FoursquareAPIRequestAdapter }

    convenience init(credentials: Credentials, version: String = "20180323") {
        switch credentials {
        case .userless(let clientID, let clientSecret):
            let adapter = FoursquareAPIRequestAdapter(clientID: clientID,
                                                      clientSecret: clientSecret,
                                                      version: version)
            self.init(requestAdapter: adapter)
        }
    }

    init(requestAdapter: FoursquareAPIRequestAdapter) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders

        sessionManager = SessionManager(configuration: configuration)
        sessionManager.adapter = requestAdapter
    }

    static let `default`: FoursquareAPI = {
        return FoursquareAPI(credentials: .userless(clientID: "12TBMZ5DUFWJD0MID5SGPPBHPJXHUVXRM4BTD3NTZQNDYN2Q",
                                                    clientSecret: "BIAQEU3F3Z2AL3M0DVZ2XD0F0N5VKSDCZCXY2V53AHAR1UZC"))
    }()
}

extension FoursquareAPI {
    enum Credentials {
        case userless(clientID: String, clientSecret: String)
    }
}

extension FoursquareAPI {
    enum Router: URLRequestConvertible {
        static let baseURL = URL(string: "https://api.foursquare.com/v2/")!

        case venuesSearch(query: String, limit: Int)
        case venuesDetail(id: String)

        // MARK: URLRequestConvertible
        func asURLRequest() throws -> URLRequest {
            let (path, params) = getPathAndParams()
            let url = Router.baseURL.appendingPathComponent(path)
            let urlRequest = URLRequest(url: url)
            let encoding = Alamofire.URLEncoding.default

            return try encoding.encode(urlRequest, with: params)
        }

        // MARK: Private Methods
        private func getPathAndParams() -> (String, Parameters) {
            switch self {
            case .venuesSearch(let query, let limit):
                return ("venues/search", ["query": query,
                                          "limit": String(limit),
                                          "intent": "global"])
            case .venuesDetail(let id):
                return ("venues/\(String(id))", [:])
            }
        }
    }
}
