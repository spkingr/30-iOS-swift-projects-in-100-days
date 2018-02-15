//
// Created by 刘庆文 on 2-11.
// Copyright (c) 2018 Liuqingwens. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController:UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    @IBOutlet weak var mapView:MKMapView!
    
    private let locationManager = CLLocationManager()
    private let geoCoder:CLGeocoder = { return CLGeocoder() }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.mapView.delegate = self
        self.locationManager.delegate = self
        
        self.mapView.showsScale = true
        let scale = MKScaleView(mapView: self.mapView)
        scale.scaleVisibility = .visible
        self.view.addSubview(scale)
        scale.translatesAutoresizingMaskIntoConstraints = false
        let constraintTop = scale.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0)
        let constraintLeading = scale.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16.0)
        constraintTop.isActive = true
        constraintLeading.isActive = true
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            self.locationManager.distanceFilter = 600
            self.locationManager.startUpdatingLocation()
        } else {
            self.showAlert(title: "Warning", information: "Location service is not available!")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [ CLLocation ])
    {
        let locationDegrees = CLLocationDegrees(0.02)
        if let coordinate = locations.first?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpanMake(locationDegrees, locationDegrees))
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.mapView.setRegion(region, animated: true)
            self.geoCoder.reverseGeocodeLocation(location) { placeMark, error in
                if let place = placeMark?.first, error == nil {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = place.name ?? "Location"
                    annotation.subtitle = "\(place.country ?? "") \(place.administrativeArea ?? "") \(place.subAdministrativeArea ?? "") \(place.name ?? "")\n[Lat: \(coordinate.latitude), Lgt: \(coordinate.longitude)]"
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    private func showAlert(title:String, information message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let doneAction = UIAlertAction(title: "Done", style: .cancel, handler: nil)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
}
