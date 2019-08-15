//
//  UIImageExtension.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
