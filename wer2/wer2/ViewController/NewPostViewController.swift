//
//  NewPostViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 06.11.2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit
import CoreData

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var PostText: UITextView!
    @IBOutlet weak var PostName: UITextField!
    
    //var taskArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Button
    @IBAction func SaveButPress(_ sender: Any) {
        saveTask { (done) in
            if done {
                //print("We need to return now")
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                //print("Try again")
            }
        }

    }
    // MARK: - Data

    func saveTask(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = Post(context: managedContext)
        task.text = PostText.text
        task.name = PostName.text
        //task.index = Double(taskArray.count + 1)
        
        do {
            try managedContext.save()
            //print("Data Saved")
            completion(true)
        } catch {
            //print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
    }

}
