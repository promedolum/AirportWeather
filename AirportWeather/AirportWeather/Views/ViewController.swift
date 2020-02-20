//
//  ViewController.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 19.02.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
    
    let provider = MoyaProvider<CheckWX>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        provider.request(.stationsByStation(icao: "uuee", radius: 30)) { [weak self] result in
//            guard let self = self else { return }
            provider.request(.stationInfo(icao: "kpie")) { [weak self] result in
                guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let data = try response.map(StationResults<Station>.self).data
                    print(data)
                } catch {
                    print("oops")
                }
            case .failure:
                print(":(")
            }
        }
    }
}

