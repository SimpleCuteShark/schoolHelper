//
//  ViewControllerMain.swift
//  wer2
//
//  Created by Alexandr Romantsov on 09/10/2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerMain: UIViewController {
    
    @IBOutlet weak var PostTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - PostTable
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = try context.fetchData(fetchRequest)
        
        return results.count
    }

            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let currentTimeTable = TimeTable[indexPath.row]
                
        cell.textLabel?.text = currentTimeTable.className
        cell.imageView?.image = currentTimeTable.mainImage
        return cell
    }
    */
}
