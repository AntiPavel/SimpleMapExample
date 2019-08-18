//
//  CarAnnotationView.swift
//  SimpleMapExample
//
//  Created by paul on 15/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

final class CarAnnotationView: MKAnnotationView {
    
    class var className: String {
        return String(describing: self)
    }
    override var reuseIdentifier: String? {
        return CarAnnotationView.className
    }
    private let iconWidth: CGFloat = 50
    private let iconHeight: CGFloat = 50
    private lazy var placeHolder = UIImage(named: "default_car")?.resized(to: iconWidth)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
//        clusteringIdentifier = "Cars"
//        displayPriority = .defaultHigh /// built in claster logic looks ugly to me
        frame = CGRect(x: 0, y: 0, width: iconWidth, height: iconHeight)
        download((annotation as? Car)?.carImageUrl ?? "", placeHolder: placeHolder)
        canShowCallout = true
        calloutOffset = CGPoint(x: -5, y: 5)
        rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        accessibilityIdentifier = annotation?.title ?? "CarAnnotation"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image = nil
    }
    
    @objc private func infoButtonAction() {
        
    }
}

private extension CarAnnotationView {

    private func download(_ urlString: String, placeHolder: UIImage?) {
        image = placeHolder
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, _, _) in
            guard let data = data,
                let downloadedImage = UIImage(data: data)?.resized(to: self?.iconWidth ?? 50.0) else {
                return
            }
            DispatchQueue.main.async {
                imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                self?.image = downloadedImage
            }
        }).resume()
    }
}
