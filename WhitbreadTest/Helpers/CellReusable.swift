//
//  CellReusable.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 17/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

protocol CellReusable: class {
    static func nib() -> UINib
    static func createReuseIdentifier() -> String
}

extension CellReusable {
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    static func createReuseIdentifier() -> String {
        return String(describing: self) + "ID"
    }
}
