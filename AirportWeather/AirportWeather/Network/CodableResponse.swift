//
//  CodableResponse.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 20.02.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import Foundation

struct StationResults<T: Codable>: Codable {
    let data: [T]
}
