//
//  StationAnnotation.swift
//  AirportWeather
//
//  Created by Zanevskiy Alexander on 28.02.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import UIKit
import MapKit

class StationAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var iata: String?
    var icao: String?
    var glyph: String?
    var colour: UIColor?
    var index: Int?

    override init() {
        self.coordinate = CLLocationCoordinate2D()
        self.title = nil
        self.iata = nil
        self.icao = nil
        self.glyph = nil
        self.colour = UIColor.white
        self.index = nil
    }
}

class StationMarkerAnnotationView: MKMarkerAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.markerTintColor = colour
        self.glyphText = glyph
    }
    
    var glyph: String? {
        get { return self.glyphText }
        set { self.glyphText = newValue }
    }
    
    var colour: UIColor? {
        get { return self.markerTintColor }
        set { self.markerTintColor = newValue }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
