//
//  ImageCache.swift
//  SimpleMapExample
//
//  Created by paul on 12/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
import UIKit

var imageCache: ImageCache = ImageCache()

final class ImageCache: NSCache<NSString, UIImage> {
    
    required override init() {
        super.init()
        totalCostLimit = totalCostLimit()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearCache),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)
    }
    
    @objc private func clearCache() {
        self.removeAllObjects()
    }
    
    private func totalCostLimit() -> Int {
        let physicalMemory = ProcessInfo.processInfo.physicalMemory
        let ratio = physicalMemory <= (1024 * 1024 * 512) ? 0.05 : 0.1
        let limit = physicalMemory / UInt64(1 / ratio)
        return limit > UInt64(Int.max) ? Int.max : Int(limit)
    }
}
