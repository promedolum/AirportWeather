//
//  StationInfoTableViewCell.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 10.03.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import UIKit

class StationInfoTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)

        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    func initialize() {
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
        self.imageView?.image = nil
    }

}
