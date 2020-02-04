//
//  TableViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 28.01.2020.
//  Copyright © 2020 Alexandr Romantsov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let DayOfWeek = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"]
    var currentTimeTable = ""
    var TimeTableArray = TimeTableModel.fetchTimeTable()
    var lessonArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DayOfWeek.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let currentDayOfWeekSection = DayOfWeek[section]
        
        return currentDayOfWeekSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var ThisTimeTableArray = TimeTableModel.fetchTimeTable()
        for ThisTimeTable in TimeTableArray {
            if (ThisTimeTable.Class == currentTimeTable) /*&& (ThisTimeTable.DayOfWeek == DayOfWeek[section]) */{
                ThisTimeTableArray.append(ThisTimeTable)
            }
        }
        return ThisTimeTableArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentDayOfWeek = DayOfWeek[tableView.numberOfSections]
        update(currentDayOfWeek: currentDayOfWeek)
        sleep(1)
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TableViewCell
        
        cell.Label.text = lessonArray[indexPath.row]
        return cell
    }


}

// MARK: - Data

extension TableViewController {
    func update(currentDayOfWeek: String) {
        db.collection("Post").whereField("Class", isEqualTo: currentTimeTable).getDocuments{ (querySnapshot, err) in
            if err != nil {
            //print("Error getting documents: \(err)")
        } else {
                self.lessonArray.removeAll()
            for document in querySnapshot!.documents {
                if currentDayOfWeek == document.get("DayOfWeek") as! String {
                //self.lessonArray.append(document.get("Lesson 0") as! String) // 0
                self.lessonArray.append(document.get("Lesson 1") as! String) // 1
                self.lessonArray.append(document.get("Lesson 2") as! String) // 2
                self.lessonArray.append(document.get("Lesson 3") as! String) // 3
                self.lessonArray.append(document.get("Lesson 4") as! String) // 4
                self.lessonArray.append(document.get("Lesson 5") as! String) // 5
                self.lessonArray.append(document.get("Lesson 6") as! String) // 6
                self.lessonArray.append(document.get("Lesson 7") as! String) // 7
                self.lessonArray.append(document.get("Lesson 8") as! String) // 8
                }
            }
            //print(self.taskArray)
        }
        }
    }
}
