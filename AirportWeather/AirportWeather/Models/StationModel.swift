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
    let country: Country?
    let elevation: Elevation?
    let iata: String?
    let latitude: Coordinate?
    let longitude: Coordinate?
    let magneticVariation: MagneticVariation?
    let sectional: String?
    let state: Country?
    let status: String?
    let timezone: Timezone?
    let type: String?
    let useage: String?
}

extension Station {
    struct Country: Codable {
        let code: String?
        let name: String?
    }
}

extension Station {
    struct Elevation: Codable {
        let feet: Float?
        let meters: Float?
        let method: String?
    }
}

extension Station {
    struct Coordinate: Codable {
        let decimal: Double?
        let degrees: String?
    }
}

extension Station {
    struct MagneticVariation: Codable {
        let position: String?
        let year: String?
    }
}

extension Station {
    struct Timezone: Codable {
        let gmt: Int?
        let dst: Int?
        let tzid: String?
    }
}
