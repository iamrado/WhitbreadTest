//
//  UIViewControllerHelper.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 17/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate<T>(name: String = String(describing: T.self), identifier: String? = nil, bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: name, bundle: bundle)

        if let identifier = identifier {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! T
        } else {
            return storyboard.instantiateInitialViewController() as! T
        }
    }
}
