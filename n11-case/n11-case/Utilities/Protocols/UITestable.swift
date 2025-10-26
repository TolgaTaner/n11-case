//
//  Testing.swift
//  n11-case
//
//  Created by Tolga Taner on 26.10.2025.
//

import UIKit

protocol UITestable: AnyObject {
    func setAccessibilityIdentifier(toView view: UIView, forKey key: UITestingIdentifier)
}
extension UITestable {
    func setAccessibilityIdentifier(toView view: UIView, forKey key: UITestingIdentifier) {
        view.accessibilityIdentifier = key.rawValue
    }
}
