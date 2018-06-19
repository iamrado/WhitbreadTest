//
//  VenueSearchTableViewCell.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class VenueSearchTableViewCell: UITableViewCell, CellReusable {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    static var reuseIdentifier: String = {
        return createReuseIdentifier()
    }()

    func configure(name: String, address: String) {
        nameLabel.text = name
        addressLabel.text = address
    }
}
