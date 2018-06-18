//
//  UITableViewHelper.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 18/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: CellReusable>(cell: T.Type) {
        let nib = T.nib()
        let identifier = T.createReuseIdentifier()
        register(nib, forCellReuseIdentifier: identifier)
    }
}
