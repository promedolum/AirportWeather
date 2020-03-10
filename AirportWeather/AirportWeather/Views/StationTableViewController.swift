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
    var cellsLabel: [String]
    var cellsDesc: [String]
    
    internal init(data: Station) {
        self.data = data
        self.cellsLabel = [""]
        self.cellsDesc = [""]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let shit = prepareTitleArray(data: data)
        for (key,value) in shit {
            cellsLabel.append(key)
            cellsDesc.append(value)
           
//            print(value)
//            cellsDesc.append(value(forKey: <#T##String#>))
        }
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
        return cellsLabel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! StationInfoTableViewCell

        
        cell.textLabel?.text = cellsLabel[indexPath.item]
        cell.detailTextLabel?.text = cellsDesc[indexPath.item]
        cell.imageView?.image = nil

        return cell
        
    }
    
    func prepareTitleArray(data: Station) -> [String:String] {
        var titles = ["":""]
        let mirror = Mirror(reflecting: data)
        for each in mirror.children {
            
            if each.value as? String ?? "" != "nil" {
                titles.updateValue(each.value as? String ?? "", forKey: each.label!)
            }
            
            
            
//            print("key: \(String(describing: each.label)), value: \(each.value)")
        }
        
        return titles
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
