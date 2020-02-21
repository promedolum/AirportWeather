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

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let provider = MoyaProvider<CheckWX>()
    let locationManager = CLLocationManager()

    var userLatitude = [Double?(0.0)]
    var userLongitude = [Double?(0.0)]
    
    let mapView = MKMapView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        mapView.showsUserLocation = true
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        var userLocation = locationManager.location?.coordinate
        userLatitude = [userLocation?.latitude]
        userLongitude = [userLocation?.longitude]
        
        let initialLocation = CLLocation(latitude: userLatitude[0] ?? 0.0, longitude: userLongitude[0] ?? 0.0)
        
        let regionRadius: CLLocationDistance = 20000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius,
                                                      longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        mapView.frame = CGRect(x:0, y:0, width:view.frame.size.width, height: view.bounds.size.height)

        //      provider.request(.stationInfo(icao: "uuee")) { [weak self] result in
        //      provider.request(.stationsByStation(icao: "uuee", radius: 30)) { [weak self] result in

        provider.request(.stationsByCoordinateRadius(lat: userLatitude[0] ?? 0.0,
                                                     lon: userLongitude[0] ?? 0.0,
                                                     radius: 50))
        { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(StationResults<Station>.self).data
                    
//                    let responseLatitude = data.map { $0.latitude?.decimal }
//                    let responseLongitude = data.map { $0.longitude?.decimal }
//                    let responseCoordinate = CLLocation(latitude: responseLatitude[0] ?? 0.0,
//                                                        longitude: responseLongitude[0] ?? 0.0)
                            
                    centerMapOnLocation(location: CLLocation(latitude: self.userLatitude[0] ?? 0.0,
                                                             longitude: self.userLongitude[0] ?? 0.0))
//                            centerMapOnLocation(location: responseCoordinate)
                    
                    self.fetchStationsOnMap(data)
                    
                } catch {
                    print("oops")
                }
            case .failure:
                print(":(")
            }
        }
        
        view.addSubview(mapView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchStationsOnMap(_ stations: [Station]) {
         for station in stations {
           let annotations = MKPointAnnotation()
           annotations.title = station.name
           annotations.coordinate = CLLocationCoordinate2D(latitude:
               station.latitude?.decimal ?? 0.0, longitude: station.longitude?.decimal ?? 0.0)
           mapView.addAnnotation(annotations)
         }
    }
}
