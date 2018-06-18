//
//  ViewController.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    private let api = FoursquareAPI(credentials: .userless(clientID: "ALHUK5X3ZKR0ERTF5LFYEDBWPBIKYJWYYFCZ1VALJVY0IUUP",
                                                           clientSecret: "5JIKUHILVLI4C3T0ZHUK02W4DKAYMETBOYQZ5RAHR13FUVFI"))

    override func viewDidLoad() {
        super.viewDidLoad()
        let request = api.sessionManager.request(FoursquareAPI.Router.venuesSearch(query: "Bar", limit: 2))
        request.responseJSON { (response) in
            print(response)
        }
    }
}

