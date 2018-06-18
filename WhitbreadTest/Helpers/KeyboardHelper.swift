//
//  KeyboardHelper.swift
//  WhitbreadTest
//
//  Created by Radoslav Blasko on 17/06/2018.
//  Copyright © 2018 Radoslav Blasko. All rights reserved.
//

import UIKit

public struct KeyboardAppearanceInfo {

    public let notification: Notification
    public let userInfo: [AnyHashable: Any]

    public init(notification: Notification) {
        self.notification = notification
        self.userInfo = notification.userInfo ?? [:]
    }

    public var beginFrame: CGRect {
        return (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    }

    public var endFrame: CGRect {
        return (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    }


    @available(iOS 9.0, *)
    public var belongsToCurrentApp: Bool {
        return (userInfo[UIKeyboardIsLocalUserInfoKey] as? Bool) ?? true

    }

    public var animationDuration: Double {
        return (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
    }

    public var animationCurve: UIViewAnimationCurve {
        guard let value = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int else { return .easeInOut }
        return UIViewAnimationCurve(rawValue: value) ?? .easeInOut
    }

    public var animationOptions: UIViewAnimationOptions {
        return UIViewAnimationOptions(rawValue: UInt(animationCurve.rawValue << 16))
    }

    public func animateAlong(_ animationBlock: @escaping (() -> Void), completion: @escaping ((_ finished: Bool) -> Void) = { _ in }) {
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: animationOptions,
            animations: animationBlock,
            completion: completion
        )}
}
