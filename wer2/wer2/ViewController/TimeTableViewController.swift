//
//  TimeTableViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 23/10/2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit

class TimeTableViewController: UITableViewController {

    var TimeTableArray = TimeTableModel.fetchTimeTable()
    var ClassSection = ["11 Класс", "10 Класс", "9 Класс", "8 Класс", "7 Класс", "6 Класс", "5 Класс"]
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        createTimer()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        db.collection("TimeTable").getDocuments{ (querySnapshot, err) in
            if let err = err {
            print("Error getting documents: \(err)")
        } else {
                self.TimeTableArray.removeAll()
            for document in querySnapshot!.documents {
                self.TimeTableArray.append(TimeTableModel(Class: ((document.get("Class")) as? String ?? "Not Work") ))
            }
            }
        }

        //print(TimeTable)
    }
    override func viewWillDisappear(_ animated: Bool) {
          cancelTimer()
      }
    override func viewWillAppear(_ animated: Bool) {
        createTimer()
    }

    // MARK: - TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        return ClassSection.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let currentClassSection = ClassSection[section]
        
        return currentClassSection
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //let section = tableView.
        update()
        var currentTimeTable = ""
        if TimeTableArray.count > indexPath.row {
        currentTimeTable = TimeTableArray[indexPath.row].Class
        } else {
        currentTimeTable = "Test"
        }
        
        cell.textLabel?.text = currentTimeTable
        return cell
    }
            
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentTimeTable = TimeTableArray[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvc = storyboard.instantiateViewController(withIdentifier: "TableViewControllerSID") as! TableViewController
        
        tvc.currentTimeTable = currentTimeTable.Class
        show(tvc, sender: nil)
    }
    
    func update() {
        db.collection("TimeTable").getDocuments{ (querySnapshot, err) in
                if err != nil {
                //print("Error getting documents: \(err)")
            } else {
                    self.TimeTableArray.removeAll()
                for document in querySnapshot!.documents {
                   self.TimeTableArray.append(TimeTableModel(Class: ((document.get("Class")) as? String ?? "Not Work") ))
                }
                print(self.TimeTableArray)
            }
        }
    }
}

extension TimeTableViewController {
    @objc func updateTimer(){
        update()
        tableView.reloadData()
    }
    func createTimer(){
        if timer == nil{
            timer = Timer.scheduledTimer(timeInterval: 0.5,
                                        target: self,
                                        selector: #selector(updateTimer),
                                        userInfo: nil,
                                        repeats: true)
        }
        timer?.tolerance = 0.2
    }
    func cancelTimer() {
      timer?.invalidate()
      timer = nil
    }
}



