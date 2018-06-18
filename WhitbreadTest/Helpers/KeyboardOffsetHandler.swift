//
//  KeyboardOffsetHandler.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 17/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

class KeyboardOffsetHandler {
    private let rootView: UIView
    private let scrollView: UIScrollView

    var enabled = false {
        didSet {
            let center = NotificationCenter.default

            if enabled {
                center.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
                center.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
            } else {
                center.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
                center.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
            }
        }
    }

    init(rootView: UIView, scrollView: UIScrollView) {
        self.rootView = rootView
        self.scrollView = scrollView
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        let info = KeyboardAppearanceInfo(notification:  notification)
        guard info.belongsToCurrentApp else { return }

        var contentInset = scrollView.contentInset
        contentInset.bottom = 0.0

        var scrollIndicatorsInset = scrollView.scrollIndicatorInsets
        scrollIndicatorsInset.bottom = contentInset.bottom

        UIView.animate(withDuration: info.animationDuration,
                       delay: 0.0,
                       options: info.animationOptions,
                       animations: { [weak self] in
                        self?.scrollView.contentInset = contentInset
                        self?.scrollView.scrollIndicatorInsets = scrollIndicatorsInset
            }, completion: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let info = KeyboardAppearanceInfo(notification:  notification)
        guard info.belongsToCurrentApp else { return }
        
        var contentInset = scrollView.contentInset
        contentInset.bottom = info.endFrame.size.height - rootView.safeAreaInsets.bottom

        var scrollIndicatorsInset = scrollView.scrollIndicatorInsets
        scrollIndicatorsInset.bottom = contentInset.bottom

        UIView.animate(withDuration: info.animationDuration,
                       delay: 0.0,
                       options: info.animationOptions,
                       animations: { [weak self] in
                        self?.scrollView.contentInset = contentInset
                        self?.scrollView.scrollIndicatorInsets = scrollIndicatorsInset
            }, completion: nil)
    }
}
