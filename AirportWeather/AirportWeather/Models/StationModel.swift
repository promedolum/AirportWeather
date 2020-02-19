//
//  StationModel.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 19.02.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import Foundation

struct Station: Codable {
    let icao: String
    let name: String
    let activated: String?
    let city: String?
//    let country: Country?
//    let elevation: Elevation?
    let iata: String?
//    let latitude: Coordinate
//    let longitude: Coordinate
    //    let magneticVariation: MagneticVariation?
    //    let radius: Radius?
    //    let sectional: String?
    //    let state: Country?
    let status: String?
    //    let sunrise: Sunrise?
    //    let timestamp: Timestamp?
//    let timezone: Timezone
    let type: String?
    //    let useage: String?
}
