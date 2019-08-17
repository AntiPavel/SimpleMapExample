//
//  CarsMapViewController.swift
//  SimpleMapExample
//
//  Created by paul on 13/08/2019.
//  Copyright © 2019 pavel. All rights reserved.
//

import UIKit
import MapKit

final public class CarsMapViewController: UIViewController, Detailable {
    
    private var viewModel: CarsViewModel
    
    lazy private var mapView: MKMapView = {
        $0.delegate = self
        $0.showsUserLocation = true
        $0.register(CarAnnotationView.self, forAnnotationViewWithReuseIdentifier: CarAnnotationView.className)
        return $0
    }(MKMapView(frame: view.bounds))
    
    lazy private var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        return locationManager
    }()
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private var currentLocation: CLLocation? {
        return locationManager.location
    }
    
    init(viewModel: CarsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureMap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureMap() {
        let mucLocation = CLLocation(latitude: 48.1351, longitude: 11.582)
        let radius: CLLocationDistance = 10000
        let coordinate = currentLocation?.coordinate ?? mucLocation.coordinate
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: radius * 2,
                                                  longitudinalMeters: radius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
        view.addSubview(mapView)
        checkLocationAuthorizationStatus()
    }

    func update() {
        DispatchQueue.main.async { [weak self] in
            self?.mapView.addAnnotations(self?.viewModel.cars ?? [])
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }

}

extension CarsMapViewController: MKMapViewDelegate {
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isEqual(mapView.userLocation) {
            let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            return annotationView
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CarAnnotationView.className) as? CarAnnotationView
        if annotationView == nil {
            annotationView = CarAnnotationView(annotation: annotation, reuseIdentifier: CarAnnotationView.className)
        }
        let carAnnotation = annotation as? Car
        annotationView?.annotation = carAnnotation
        annotationView?.setup()
        return annotationView
    }
    
    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let car  = view.annotation as? Car else { return }
        showDetails(car,
                    completion: { })
    }
}
