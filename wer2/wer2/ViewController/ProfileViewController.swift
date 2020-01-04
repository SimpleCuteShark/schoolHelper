//
//  ProfileViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 11.11.2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit
import Firebase
import CoreData
let db = Firestore.firestore()

let appDelegate2 = UIApplication.shared.delegate as? AppDelegate
class ProfileViewController: UIViewController {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Button: UIButton!
    
    var nowUs = [NowUs]()
    var signup :Bool = true{
        willSet{
            if newValue{
                let user = Auth.auth().currentUser
                if let user = user {
                    let email = user.email!
                //let NumNowUs = nowUs
                db.collection("Users").document(email).getDocument { (document, error) in
                    if let document = document, document.exists {
                        
                        self.NameLabel.text = "Имя пользователя:"
                        self.Name.isHidden = false
                        self.Name.text = document.get("Name") as? String
                        self.EmailLabel.isHidden = false
                        self.Email.text = document.get("Email") as? String
                        self.Button.setTitle("Выйти из аккаунта", for: .normal)
                    //Button.titleLabel?.textColor = UIColor.red
                        self.Button.setTitleColor(UIColor.red, for: .normal)
                } else {
                    //let nu = nowUs[NumNowUs.endIndex]
                        self.NameLabel.text = "Ошибка входа в аккаунт"
                        self.Name.isHidden = false
                        self.Name.text = "пожалуйста, попробуйте позже"
                        self.EmailLabel.isHidden = true
                        self.Email.text = "Вы можете выйти и войти повторно"
                        self.Button.setTitle("Выйти из аккаунта", for: .normal)
                    //Button.titleLabel?.textColor = UIColor.red
                        self.Button.setTitleColor(UIColor.red, for: .normal)
                    } } }
            } else {
                //deleteNowUs()
                NameLabel.text = "Вы еще не вошли"
                Name.isHidden = true
                EmailLabel.isHidden = true
                Email.text = "Зарегестрируйтесь сейчас:"
                Button.setTitle("Зарегестрироваться", for: .normal)
                //Button.titleLabel?.textColor = UIColor.blue
                Button.setTitleColor(UIColor.blue, for: .normal)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener{(auth, user) in
        if user == nil {
            self.signup = false
        } else {
            self.signup = true
            }
    }
    }
    override func viewWillAppear(_ animated: Bool) {
        //fetchData()
    }
    
    @IBAction func ButtonPress(_ sender: Any) {
        if signup == false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tvc = storyboard.instantiateViewController(withIdentifier: "AuthSID")
            present(tvc, animated: true, completion: nil)
        } else {
            do{
                try Auth.auth().signOut()
                signup = !signup
                //print(NumNowUs)
            } catch{
                print(error)
            }
        }
    }
    /*
    func fetchData() {
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NowUs")
            do {
                nowUs = try managedContext.fetch(request) as! [NowUs]
            } catch {
                print(error)
            }
    }
    
    func deleteNowUs() {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let NowUsAr = [NowUs]()
        let n = NowUsAr.count;
        if (n > 0) {
            for i in ((nowUs.startIndex)-1)...(n) {
                managedContext.delete(NowUsAr[i])
            do {
                try managedContext.save()
                print("Data Deleted")
                
            } catch {
                //print("Failed to delete data: ", error.localizedDescription)
            }
        }
    }
}
    */
}
