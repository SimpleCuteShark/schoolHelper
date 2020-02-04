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
    
    let taskArray = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Button
    
    @IBAction func SaveButPress(_ sender: Any) {
        saveTask()
    }
    
    // MARK: - Data

    func saveTask() {
            db.collection("Post").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let NAME = self.PostName.text ?? ""
                let TEXT = self.PostText.text ?? ""
                for document in querySnapshot!.documents {
                    if (document.get("name") as? String ?? "") != NAME {
                        db.collection("Post").document(NAME).setData(["name": NAME, "tags": "not work", "text": TEXT])
                        self.closeWindow()
                    }
                }
            }
        }
    }
    
    // MARK: - Novigation
    
    func closeWindow() {
       navigationController?.popViewController(animated: true)
       self.dismiss(animated: true, completion: nil)
    }
}
