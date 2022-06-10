//
//  SwipeBack.swift
//  BetterSight
//
//  Created by f on 10.06.2022.
//

import UIKit

// Hiding the navigation bar causes to lose swipe back. To prevent that, this extension is added.
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}


