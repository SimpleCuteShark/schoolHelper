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
                let NumNowUs = nowUs
                if NumNowUs.count != 0 {
                    let nu = nowUs[NumNowUs.startIndex]
                    NameLabel.text = "Имя пользователя:"
                    Name.isHidden = false
                    Name.text = nu.name
                    EmailLabel.isHidden = false
                    Email.text = nu.email
                    Button.setTitle("Выйти из аккаунта", for: .normal)
                    //Button.titleLabel?.textColor = UIColor.red
                    Button.setTitleColor(UIColor.red, for: .normal)
                } else {
                    //let nu = nowUs[NumNowUs.endIndex]
                    NameLabel.text = "Имя пользователя:"
                    Name.isHidden = false
                    Name.text = "Not work"
                    EmailLabel.isHidden = false
                    Email.text = "Lox"
                    Button.setTitle("Выйти из аккаунта", for: .normal)
                    //Button.titleLabel?.textColor = UIColor.red
                    Button.setTitleColor(UIColor.red, for: .normal)
                }
            } else {
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
        fetchData()
    }
    
    @IBAction func ButtonPress(_ sender: Any) {
        if signup == false {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tvc = storyboard.instantiateViewController(withIdentifier: "AuthSID")
            present(tvc, animated: true, completion: nil)
        } else {
            do{
                try Auth.auth().signOut()
                var NumNowUs = nowUs
                signup = !signup
                NumNowUs.removeAll()
                print(NumNowUs)
            } catch{
                print(error)
            }
        }
    }
    
    func fetchData() {
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NowUs")
            do {
                nowUs = try managedContext.fetch(request) as! [NowUs]
            } catch {
                print(error)
            }
    }
}
