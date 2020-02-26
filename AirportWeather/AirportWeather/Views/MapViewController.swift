//
//  MapViewController.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 19.02.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import UIKit
import Moya
import MapKit
import CoreLocation

class MapViewController:    UIViewController,
                            MKMapViewDelegate,
                            UIGestureRecognizerDelegate,
                            CLLocationManagerDelegate {
    
    let provider = MoyaProvider<CheckWX>()
    let locationManager = CLLocationManager()

    var userLatitude = [Double?(0.0)]
    var userLongitude = [Double?(0.0)]
    
    let mapView = MKMapView()
    let regionRadius: CLLocationDistance = 20000
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        mapView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height: view.bounds.size.height)
        
        let mapPanGesture = UIPanGestureRecognizer(target: self, action: #selector(self.didDragMap(_:)))
        mapPanGesture.delegate = self
        mapView.addGestureRecognizer(mapPanGesture)
        
        let mapPinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(self.didPinchMap(_:)))
        mapPinchGesture.delegate = self
        mapView.addGestureRecognizer(mapPinchGesture)
        
        let userLocation = locationManager.location?.coordinate
        userLatitude = [userLocation?.latitude]
        userLongitude = [userLocation?.longitude]
        
        let initialLocation = CLLocation(latitude: userLatitude[0] ?? 0.0,
                                         longitude: userLongitude[0] ?? 0.0)

        centerMapOnLocation(location: initialLocation)
        fetchStationsInfo(latitude: self.userLatitude[0] ?? 0.0,
                          longitude: self.userLongitude[0] ?? 0.0,
                          radius: mapView.currentRadius())
        
        view.addSubview(mapView)
    }
    
    
    func fetchStationsInfo(latitude: Double, longitude: Double, radius: Double) {
        
        provider.request(.stationsByCoordinateRadius(lat: latitude,
                                                     lon: longitude,
                                                     radius: radius))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(StationResults<Station>.self).data
                    self.fetchStationsOnMap(data)
                } catch {
                    print("Could not parse data")
                }
            case .failure:
                print("Network error")
                print(result)
            }
        }
    }
    
    func fetchStationsOnMap(_ stations: [Station]) {
        
        let storedAnnotations = mapView.annotations
        var newAnnotations: [MKAnnotation] = []
        
        for station in stations {
            let annotations = MKPointAnnotation()
            annotations.title = station.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: station.latitude?.decimal ?? 0.0,
                                                            longitude: station.longitude?.decimal ?? 0.0)
            newAnnotations.append(annotations)
        }
        mapView.addAnnotations(newAnnotations)
        mapView.removeAnnotations(storedAnnotations)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let center = mapView.centerCoordinate
            let radius = mapView.currentRadius()
            fetchStationsInfo(latitude: center.latitude, longitude: center.longitude, radius: radius)
        }
    }
    
    @objc func didPinchMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            let radius = mapView.currentRadius()
            let center = mapView.centerCoordinate
            fetchStationsInfo(latitude: center.latitude, longitude: center.longitude, radius: radius)
        }
    }
    
}
    

extension MKMapView {

    func topCenterCoordinate() -> CLLocationCoordinate2D {
        return self.convert(CGPoint(x: self.frame.size.width / 2.0, y: 0), toCoordinateFrom: self)
    }

    func currentRadius() -> Double {
        let centerLocation = CLLocation(latitude: self.centerCoordinate.latitude, longitude: self.centerCoordinate.longitude)
        let topCenterCoordinate = self.topCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        
        
        if centerLocation.distance(from: topCenterLocation) >= 100000 {
            return 100.0
        } else {
            return round(centerLocation.distance(from: topCenterLocation) / 1000)
        }
    }
}
