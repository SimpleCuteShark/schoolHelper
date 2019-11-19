//
//  AuthViewController.swift
//  wer2
//
//  Created by Alexandr Romantsov on 11.11.2019.
//  Copyright © 2019 Alexandr Romantsov. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class AuthViewController: UIViewController {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Button: UIButton!
    
    var nowUs = [NowUs]()
    var singup :Bool = true{
        willSet{
            if newValue {
                Label.text = "Регистрация"
                Name.isHidden = false
                Label2.text = "У вас уже есть аккаунт?"
                Button.setTitle("Войти", for: .normal)
            } else {
                Label.text = "Вход"
                Name.isHidden = true
                Button.setTitle("Зарегестрироваться", for: .normal)
                Label2.text = "Ещё не зарегестрированны?"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        Name.delegate = self
        email.delegate = self
        pass.delegate = self
    }
    @IBAction func ButtonPress(_ sender: Any) {
        singup = !singup
    }
    func Alert() {
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func saveTask() {
        let name = Name.text!
        //let Pass = pass.text!
        let Email = email.text!
        guard let managedContext = appDelegate2?.persistentContainer.viewContext else { return }
        let us = NowUs(context: managedContext)
        if (singup) {
            us.name = name
            us.email = Email

            us.master = false
        } else {
            us.name = name
            us.email = Email
            
            us.master = false
        }
        print(nowUs)
        do {
            try managedContext.save()
            print("роботает")
        } catch {
            print("сломалося")
        }
    }
}

extension AuthViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = Name.text!
        let Pass = pass.text!
        let Email = email.text!
        
        if (singup) {
            if (!name.isEmpty && !Pass.isEmpty && !Email.isEmpty) {
                Auth.auth().createUser(withEmail: Email, password: Pass) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            let db = Firestore.firestore()
                            db.collection("Users").document(Email).setData([
                                "Name": name,
                                "Pass": Pass,
                                "Email": Email,
                                "Master": false
                            ]) { err in
                                if let err = err {
                                    print("Error writing document: \(err)")
                                } else {
                                    print("Document successfully written!")
                                }
                            }
                            self.saveTask();
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            } else {
                Alert()
            }
        } else {
            if (!Pass.isEmpty && !Email.isEmpty) {
                Auth.auth().signIn(withEmail: Email, password: Pass) { (result, error) in
                    if error == nil {
                        self.saveTask();
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            } else {
               Alert()
            }
        }
        return true
    }
}
