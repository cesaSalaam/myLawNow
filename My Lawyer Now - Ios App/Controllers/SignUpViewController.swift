//
//  SignUpViewController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/15/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController{

    var refLawyers: DatabaseReference!
    var newLawyer = Lawyer()
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firmName: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refLawyers = Database.database().reference().child("Lawyers")
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let err = error{
                print(err.localizedDescription)
            }else{
                
                Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    if let err = error{
                        print("there is an error")
                        print(err.localizedDescription)
                    } else{
                        print("well done")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "homeController")
                        self?.present(controller, animated: true, completion: nil)
                        
                    }
                }
                
                self.newLawyer.name = self.name.text!
                self.newLawyer.phoneNumber = self.phoneNumber.text!
                self.newLawyer.lawFirm = self.firmName.text!
                self.newLawyer.email = email
                let lawObject = self.newLawyer.convertToDict()
                
            self.refLawyers.child((Auth.auth().currentUser?.uid)!).setValue(lawObject, withCompletionBlock: { (error, reference) in
                    if let err = error{
                        print("there is an error")
                        print(err.localizedDescription)
                    }else{
                        print("added \(lawObject["name"]!) to database.")
                    }
                })
                
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
