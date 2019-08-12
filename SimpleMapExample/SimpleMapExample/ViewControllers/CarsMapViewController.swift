//
//  CarsMapViewController.swift
//  SimpleMapExample
//
//  Created by paul on 13/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit
import MapKit

final public class CarsMapViewController: UIViewController {
    
    private var viewModel: CarsViewModel
    
    init(viewModel: CarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var mapView: MKMapView = {
        $0.delegate = self
        $0.showsUserLocation = true
        return $0
    }(MKMapView(frame: view.bounds))

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        view.addSubview(mapView)
    }

    func configureMap() {
        let location = CLLocation(latitude: 48.2, longitude: 11.6)
        let radius: CLLocationDistance = 60000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: radius * 2,
                                                  longitudinalMeters: radius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func update() {
        DispatchQueue.main.async { [weak self] in self?.mapView.addAnnotations(self?.viewModel.cars ?? []) }
    }

}

extension CarsMapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseIdentifier = "CarAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        }
        annotationView?.pinTintColor = .blue
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        icon.download((annotation as? Car)?.carImageUrl ?? "", placeHolder: UIImage(named: "Circle"))
        annotationView?.leftCalloutAccessoryView = icon
      //  annotationView?.detailCalloutAccessoryView = icon
        return annotationView
    }
}
