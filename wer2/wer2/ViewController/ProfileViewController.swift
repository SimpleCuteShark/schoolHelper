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
    
    var signup :Bool = true{
        willSet{
            if newValue{
                let user = Auth.auth().currentUser
                if let user = user {
                    let email = user.email!
                    // ввывод аккаунта на экран или предложение зарегестрироваться/войти
                db.collection("Users").document(email).getDocument { (document, error) in
                    if let document = document, document.exists {
                        self.NameLabel.text = "Имя пользователя:"
                        self.Name.isHidden = false
                        self.Name.text = document.get("Name") as? String
                        self.EmailLabel.isHidden = false
                        self.Email.text = document.get("Email") as? String
                        self.Button.setTitle("Выйти из аккаунта", for: .normal)
                        self.Button.setTitleColor(UIColor.red, for: .normal)
                } else {
                        self.NameLabel.text = "Ошибка входа в аккаунт"
                        self.Name.isHidden = false
                        self.Name.text = "пожалуйста, попробуйте позже"
                        self.EmailLabel.isHidden = true
                        self.Email.text = "Вы можете выйти и войти повторно"
                        self.Button.setTitle("Выйти из аккаунта", for: .normal)
                        self.Button.setTitleColor(UIColor.red, for: .normal)
                    } } }
            } else {
                NameLabel.text = "Вы еще не вошли"
                Name.isHidden = true
                EmailLabel.isHidden = true
                Email.text = "Зарегестрируйтесь сейчас:"
                Button.setTitle("Зарегестрироваться", for: .normal)
                Button.setTitleColor(UIColor.blue, for: .normal)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // проверка авторизации
        Auth.auth().addStateDidChangeListener{(auth, user) in
        if user == nil {
            self.signup = false
        } else {
            self.signup = true
            }
    }
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
}
