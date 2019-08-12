//
//  UIImageExtension.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func download(_ urlString: String, placeHolder: UIImage?) {
        DispatchQueue.global().async { [weak self] in
            DispatchQueue.main.async { self?.image = nil }
            if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
                DispatchQueue.main.async {
                    self?.image = cachedImage
                    return
                }
            }
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async { self?.image = placeHolder }
                return
            }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                guard error == nil else {
                    DispatchQueue.main.async { self?.image = placeHolder }
                    return
                }
                DispatchQueue.main.async {
                    guard let data = data, let downloadedImage = UIImage(data: data) else {
                        DispatchQueue.main.async { self?.image = placeHolder }
                        return
                    }
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self?.image = downloadedImage.resizeImage(targetSize: self?.image?.size ?? CGSize.zero)
                }
            }).resume()
        }
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ? CGSize(width: size.width * heightRatio,
                                                        height: size.height * heightRatio):
                                                 CGSize(width: size.width * widthRatio,
                                                       height: size.height * widthRatio)
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func download(_ urlString: String) {
        DispatchQueue.global().async {
            if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
                DispatchQueue.main.async { [weak self] in
                    self? = cachedImage
                    return
                }
            }
            
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                
                guard error == nil else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let data = data, let downloadedImage = UIImage(data: data) else { return }
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self? = downloadedImage
                }
            }).resume()
        }
    }
}
