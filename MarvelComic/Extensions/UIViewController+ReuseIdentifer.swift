//
//  UIViewController+ReuseIdentifer.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import Foundation
import UIKit
extension UIViewController {
    static var reuseIdentifier: String {
        return "\(String(describing: self))"
    }
}
