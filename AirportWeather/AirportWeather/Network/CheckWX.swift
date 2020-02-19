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
    case station
}

extension CheckWX: TargetType {
    
    public var baseURL: URL {
    return URL(string: "https://api.checkwx.com")!
  }

    public var path: String {
        switch self {
        case .station: return "/station/"
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
