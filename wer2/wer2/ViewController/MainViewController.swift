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
    var taskArray = PostModel.fetchPost()
    var timer: Timer?
    let cellid = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createTimer()
        
        let user = Auth.auth().currentUser
        if let user = user {
            let email = user.email!
        
        db.collection("Users").document(email).getDocument { (document, error) in
        if let document = document, document.exists {
            self.master = document.get("Master") as? Bool ?? false
        } else {
            self.master = false
            } } } else {
            master = false
        }
        
        if master == true {
            newPostButton.isEnabled = true
            newPostButton.tintColor = UIColor.systemBlue
        } else {
            newPostButton.isEnabled = false
            newPostButton.tintColor = UIColor.clear
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cancelTimer()
    }
    
    @IBAction func NewPostButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let npvc = storyboard.instantiateViewController(withIdentifier: "NewPostControllerSID")
        
        show(npvc, sender: nil)
    }
    
    func fetchyData(){
        if taskArray.count > 0 {
            tv.isHidden = false
            //print("www")
        } else {
            tv.isHidden = true
            //print("xxx")
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
        //print(taskArray.count)
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! TableViewCell
        let task = taskArray[indexPath.row]
        cell.Label.text = task.text
        cell.Name.text = task.name
        //print(cell.Label.text ?? "not work")
        //print(cell.Name.text ?? "not work")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, weightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentPost = taskArray[indexPath.row]
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pvc = self.storyboard?.instantiateViewController(withIdentifier: "PostViewControllerSID") as! PostViewController
        
        pvc.currentPost = currentPost.text
        pvc.Master = master
        
        show(pvc, sender: nil)
    }
    /*
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellid, for: indexPath) as! TableViewCell
        self.deleteData(name: cell.Name.text ?? "")
        self.fetchyData()
    }
    let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
        if (master == true) { return swipeActions }
        else { return nil }
    }
 */
    
}
    // MARK: - Data

extension MainViewController {
    
    //func deleteData(name: String) {
    //    db.collection("Post").document(name).delete()
    //}
    
    func update() {
        db.collection("Post").getDocuments{ (querySnapshot, err) in
            if err != nil {
            //print("Error getting documents: \(err)")
        } else {
                self.taskArray.removeAll()
            for document in querySnapshot!.documents {
                self.taskArray.append(PostModel(name: (document.get("name")) as! String, tags: (document.get("tags")) as! String, text: (document.get("text")) as! String))
            }
            //print(self.taskArray)
        }
    }
        if master == true {
            newPostButton.isEnabled = true
            newPostButton.tintColor = UIColor.systemBlue
        } else {
            newPostButton.isEnabled = false
            newPostButton.tintColor = UIColor.clear
        }
    }
}

// MARK: - Timer

extension MainViewController {
    @objc func updateTimer(){
        update()
        fetchyData()
        tv.reloadData()
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

