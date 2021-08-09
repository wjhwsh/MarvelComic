//
//  UIImageViewExtension.swift
//  MarvelComic
//
//  Created by Jianhua Wang on 8/8/21.
//

import Foundation
import UIKit
extension UIImageView {
    open override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        if let image = self.image, self.contentMode == UIView.ContentMode.scaleAspectFit {
            size.height =  self.frame.width * image.size.height / image.size.width
        }
        return size
    }
}
