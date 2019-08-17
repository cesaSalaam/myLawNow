//
//  verifyPinController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/7/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class verifyPinController: UIViewController {

    @IBOutlet weak var pinField: UITextField!
    var securePin: String?
    var tempLawyer: Lawyer?
    var refLawyers = Database.database().reference().child("Lawyers")
    var password: String?
    
    @IBAction func verifyCode(_ sender: Any) {
        if pinField.text! == securePin!{
            let lawObject = self.tempLawyer!.convertToDict()
            
            Auth.auth().createUser(withEmail: (self.tempLawyer?.email)!, password:self.password!) { (authResult, error) in
                if let err = error{
                    print(err.localizedDescription)
                    let alert = UIAlertController(title: "Oh no!", message: err.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    Auth.auth().signIn(withEmail: (self.tempLawyer?.email)!, password: self.password!) { [weak self] user, error in
                        guard let strongSelf = self else { return }
                        if let err = error{
                            print("there is an error")
                            print(err.localizedDescription)
                        } else{
                            self?.refLawyers.child((Auth.auth().currentUser?.uid)!).setValue(lawObject, withCompletionBlock: { (error, reference) in
                                if let err = error{
                                    print("there is an error")
                                    print(err.localizedDescription)
                                }else{
                                    print("added \(lawObject["name"]!) to database.")
                                    print("well done. user is signed in")
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let controller = storyboard.instantiateViewController(withIdentifier: "homeController")
                                    self!.present(controller, animated: true, completion: nil)
                                    
                                }
                            })
                        }
                    }
                }
            }
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
