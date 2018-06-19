//
//  FoursquareAPIResponses.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import Foundation
import ObjectMapper

extension FoursquareAPI {
    enum Response {
        struct Venues: ImmutableMappable {
            struct Venue: ImmutableMappable, Equatable {
                let name: String
                let location: Location
                let id: String

                init(map: Map) throws {
                    id = try map.value("id")
                    name = try map.value("name")
                    location = try map.value("location")
                }

                static func == (lhs: FoursquareAPI.Response.Venues.Venue, rhs: FoursquareAPI.Response.Venues.Venue) -> Bool {
                    return lhs.id == rhs.id
                }

                struct Location: ImmutableMappable {
                    let address: String?

                    init(map: Map) throws {
                        address = try? map.value("address")
                    }
                }
            }

            let venues: [Venue]

            init(map: Map) throws {
                venues = try map.value("response.venues")
            }
        }
    }
}
