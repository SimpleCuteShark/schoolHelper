//
//  MainViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 06.11.2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit
import CoreData
import Firebase

let appDelegate = UIApplication.shared.delegate as? AppDelegate
class MainViewController: UIViewController {

    // MARK: - Init
    
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var newPostButton: UIBarButtonItem!
    
    var master = false;
    var taskArray = [Post]()
    let cellid = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callDelegates()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchyData()
        tv.reloadData()
        
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email!
        
        db.collection("Users").document(email).getDocument { (document, error) in
        if let document = document, document.exists {
            self.master = document.get("Master") as? Bool ?? false
        } else {
            
        } } }
        
        if master == true {
            newPostButton.isEnabled = true
            newPostButton.tintColor = UIColor.white
        } else {
            newPostButton.isEnabled = false
            newPostButton.tintColor = UIColor.clear
        }
    }
    
    @IBAction func NewPostButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tvc = storyboard.instantiateViewController(withIdentifier: "NewPostControllerSID")
        
        show(tvc, sender: nil)
    }
    
    func fetchyData(){
         fetchData { (done) in
             if done {
                 if taskArray.count > 0 {
                     tv.isHidden = false
                 } else {
                     tv.isHidden = true
                 }
             }
         }
    }
    
    func callDelegates(){
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
    }
}

    // MARK: - TableView
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TableViewCell
        let task = taskArray[indexPath.row]
        cell.Label.text = task.text
        cell.Name.text = task.name
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, weightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
        self.deleteData(indexPath: indexPath)
        self.fetchyData()
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        if (master == true) { return swipeActions }
        else { return nil }
    }
    
}
    // MARK: - Data

extension MainViewController {
    func fetchData(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            taskArray = try  managedContext.fetch(request) as! [Post]
            //print("Data fetched, no issues")
            completion(true)
        } catch {
            //print("Unable to fetch data: ", error.localizedDescription)
            completion(false)
        }
        
    }
    
    func deleteData(indexPath: IndexPath) {
         guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(taskArray[indexPath.row])
        do {
            try managedContext.save()
            //print("Data Deleted")
        } catch {
            //print("Failed to delete data: ", error.localizedDescription)
        }
    }
    
}
