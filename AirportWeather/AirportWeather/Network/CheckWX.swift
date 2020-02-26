//
//  CheckWX.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 19.02.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import Foundation
import Moya

public enum CheckWX {
    case station,
         stationInfo(icao: String),
         stationsByStation(icao: String, radius: Int),
         stationByCoordinate(lat: Double, lon: Double),
         stationsByCoordinateRadius(lat: Double, lon: Double, radius: Double),
         stationTimestamp(icao: String)
}

extension CheckWX: TargetType {
    
    public var baseURL: URL {
    return URL(string: "https://api.checkwx.com")!
  }

    public var path: String {
        switch self {
        case .station: return "/station/"
        case .stationInfo(let icao): return "/station/\(icao)"
        case .stationsByStation(let icao, let radius): return "/station/\(icao)/radius/\(radius)"
        case .stationByCoordinate(let lat, let lon): return "/station/lat/\(lat)/lon/\(lon)"
        case .stationsByCoordinateRadius(let lat, let lon, let radius): return "/station/lat/\(lat)/lon/\(lon)/radius/\(radius)"
        case .stationTimestamp(let icao): return "/station/\(icao)/timestamp"
        }
  }

    public var method: Moya.Method {
        return .get
  }

    public var sampleData: Data {
        return Data()
  }

    public var task: Task {

        switch self {
        case .station: return .requestPlain
        case .stationInfo(icao: _): return .requestPlain
        case .stationsByStation(let icao, let radius):
            return .requestPlain
        case .stationByCoordinate(let lat, let lon):
            return .requestPlain
        case .stationsByCoordinateRadius(let lat, let lon, let radius):
            return .requestPlain
        case .stationTimestamp(let icao):
            return .requestPlain
        }
  }

    public var headers: [String: String]? {
    
        return ["X-API-Key": "\(CheckWX.apiKey)",
                "Content-Type": "application/json"]

  }

    public var validationType: ValidationType {
        return .successCodes
  }
}
