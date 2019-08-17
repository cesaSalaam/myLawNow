//
//  verificationController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class verificationController: UIViewController {

    // MARK: - variables
    @IBOutlet weak var verificationPin: UITextField!
    var thisLawFirm = lawFirm()
    var admin = Admin()
    var pin: String?
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Admin object: \(self.admin)")
        print("lawFirm object: \(self.thisLawFirm)")
        // Do any additional setup after loading the view.
    }
    // MARK: - IBActions
    @IBAction func verifyClicked(_ sender: Any) {
        if verificationPin.text! == pin{
            print(password)
            Auth.auth().createUser(withEmail: (self.admin.email)!, password:self.password) { (authResult, error) in
                if let err = error{
                        print(err.localizedDescription)
                        let alert = UIAlertController(title: "Oh no!", message: err.localizedDescription , preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                    
                    self.admin.UID = Auth.auth().currentUser?.uid
                    self.thisLawFirm.admin = Auth.auth().currentUser?.uid
                    self.thisLawFirm.lawyers = " "
                    self.admin.lawFirm = (Auth.auth().currentUser?.uid)! + self.thisLawFirm.name!
                    var adminObject = self.admin.convertToDict()
                    var lawFirmObject = self.thisLawFirm.convertToDict()
                    
                    fireServices.FIRBase.refAdmins.child((Auth.auth().currentUser?.uid)!).setValue(adminObject, withCompletionBlock: {(error, reference) in
                        if let err = error{
                            print("there is an error")
                            print(err.localizedDescription)
                        }else{
                            print("added \(adminObject["name"]!) to database.")
                            UserDefaults.standard.set(adminObject, forKey: "admin")
                            print("object from user defaults\(UserDefaults.standard.object(forKey: "admin"))")
                            print("well done. user is signed in")
                        }
                    })
                    fireServices.FIRBase.refLawFirms.child((self.admin.lawFirm)!).setValue(lawFirmObject, withCompletionBlock: { (error, reference) in
                        if error != nil{
                            print("there's an error for the law object")
                        }else{
                            print("everything is working well -> to home admin page.")
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyboard.instantiateViewController(withIdentifier: "adminHomeController")
                            self.present(controller, animated: true, completion: nil)
                        }
                    })
                    
                    Auth.auth().signIn(withEmail: (self.admin.email)!, password: self.password) { [weak self] user, error in
                            guard let strongSelf = self else { return }
                            if let err = error{
                                print("there is an error")
                                print(err.localizedDescription)
                            } else{
                            }
                        }
                    }
                }
        }else{
            let alert = UIAlertController(title: "Incorrect!", message: "Hmm, that doesn't seem like its the correct pin." , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
