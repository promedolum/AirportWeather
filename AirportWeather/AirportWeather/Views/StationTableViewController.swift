//
//  StationTableVC.swift
//  AirportWeather
//
//  Created by Alexander Zanevskiy on 08.03.2020.
//  Copyright © 2020 ZuluTeam. All rights reserved.
//

import UIKit

class StationTableViewController: UITableViewController {
    
    let data: Station
    var cellsLabels: [String]
    var cellsDescriptions: [String]
    
    internal init(data: Station) {
        self.data = data
        self.cellsLabels = []
        self.cellsDescriptions = []
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let stationInfoArrays = prepareInfoArrays(data: data)
        cellsLabels = stationInfoArrays.titles
        cellsDescriptions = stationInfoArrays.values
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let tv = tableView
        tv!.register(StationInfoTableViewCell.self, forCellReuseIdentifier: "customCell")
        
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
        
//        print(data)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellsLabels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! StationInfoTableViewCell

        cell.textLabel?.text = cellsLabels[indexPath.item]
        cell.detailTextLabel?.text = cellsDescriptions[indexPath.item]
        cell.imageView?.image = nil

        return cell
        
    }
    
    func prepareInfoArrays(data: Station) -> (titles: [String], values: [String]) {
        
        var titles: [String] = []
        var values: [String] = []
        
        titles.append("Name")
        values.append(data.name)
        
        titles.append("ICAO")
        values.append(data.icao)
        
        if let iata = data.iata {
            titles.append("IATA")
            values.append(iata)
        }
        
        if let type = data.type {
            titles.append("Type")
            values.append(type)
        }
        
        if let useage = data.useage {
            titles.append("Useage")
            values.append(useage)
        }
        
        if let status = data.status {
            titles.append("Status")
            values.append(status)
        }
        
        if let country = data.country {
            if let code = country.name {
                titles.append("Country")
                values.append(code)
            }
        }
        
        if let state = data.state {
            if let code = state.code {
                titles.append("State")
                values.append(code)
            }
        }
        
        if let city = data.city {
            titles.append("City")
            values.append(city)
        }
        
        if let latitude = data.latitude {
            if let decimal = latitude.decimal {
                titles.append("Latitude")
                values.append(String(decimal))
            }
        }
        
        if let longitude = data.longitude {
            if let decimal = longitude.decimal {
                titles.append("Longitute")
                values.append(String(decimal))
            }
        }
        
        if let elevation = data.elevation {
            let meters = NSString(format: "%.3f", elevation.meters!) as String
            titles.append("Elevation (meters)")
            values.append(meters)
        }
        
        if let timezone = data.timezone {
            if let gmt = timezone.gmt {
                titles.append("Timezone (GMT)")
                values.append(String(gmt))
            }
        }
        
        return (titles, values)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
