//
//  PostViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 20.01.2020.
//  Copyright © 2020 Alexandr Romantsov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController{

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var ButtonDelete: UIButton!
    
    var currentPost: String = ""
    var Master: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TextLabel.text = currentPost
        if Master == true {
            //ButtonDelete.tintColor = UIColor.systemRed
            ButtonDelete.isHidden = false
        } else {
            ButtonDelete.isHidden = true
        }
        db.collection("Post").getDocuments{ (querySnapshot, err) in
                if err != nil {
                //print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if document.get("text") as? String == self.currentPost {
                        self.NameLabel.text = document.get("name") as? String
                        
                        self.TextLabel.text = document.get("text") as? String
                        
                    }
                }
            }
        }
        
    }
    
    @IBAction func Delete(_ sender: Any) {
        db.collection("Post").document(NameLabel.text!).delete()
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

