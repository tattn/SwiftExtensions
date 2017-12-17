//
//  UIImage+.swift
//  SwiftExtensions
//
//  Created by Tatsuya Tanaka on 20171218.
//  Copyright © 2017年 tattn. All rights reserved.
//

import UIKit

public extension UIImage {
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            self.init()
            return
        }

        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()

        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
}
