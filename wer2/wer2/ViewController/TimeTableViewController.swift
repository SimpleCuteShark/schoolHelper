//
//  TimeTableViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 23/10/2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit

protocol TimeTableObjectSelectedDelegate: class {
    func timeTableObjectSelected(timetableObject: TimeTableModel)
}

class TimeTableViewController: UITableViewController {

    var TimeTable = TimeTableModel.fetchTimeTable()
    weak var delegate: TimeTableObjectSelectedDelegate? 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return TimeTable.count
    }

            
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let currentTimeTable = TimeTable[indexPath.row]
                
        cell.textLabel?.text = currentTimeTable.className
        cell.imageView?.image = currentTimeTable.mainImage
        return cell
    }
            
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("\(indexPath.row)")
        let currentTimeTable = TimeTable[indexPath.row]
        delegate?.timeTableObjectSelected(timetableObject: currentTimeTable)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvc = storyboard.instantiateViewController(withIdentifier: "TimeViewControllerSID")
        
        show(tvc, sender: nil)
    }
}



