//
//  UIView+ReuseIdentifier.swift
//  AppPractise
//
//  Created by Jianhua Wang on 7/20/21.
//

import Foundation
import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return "\(String(describing: self))"
    }
}
