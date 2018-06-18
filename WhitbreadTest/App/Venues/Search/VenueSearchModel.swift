//
//  VenueSearchModel.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class VenueSearchModel {
    enum Result {
        case error(error: Error?)
        case success
    }

    var searchTerm: String? { didSet { performSearch() } }
    var limit: Int = 100
    var onSearchFinished: ((Result) -> Void)?

    private(set) var items = [FoursquareAPI.Response.Venues.Venue]()
    private let api: FoursquareAPI

    init(api: FoursquareAPI) {
        self.api = api
    }

    private func performSearch() {
        guard let searchTerm = searchTerm else {
            items = []
            onSearchFinished?(Result.success)
            return
        }

        let request = api.sessionManager.request(FoursquareAPI.Router.venuesSearch(query: searchTerm, limit: limit))
        request.responseObject { [weak self] (response: DataResponse<FoursquareAPI.Response.Venues>) in
            switch response.result {
            case .success(let venueResponse):
                self?.items = venueResponse.venues
                self?.onSearchFinished?(.success)
            case .failure(let error):
                self?.items = []
                self?.onSearchFinished?(.error(error: error))
            }
        }
    }
}
