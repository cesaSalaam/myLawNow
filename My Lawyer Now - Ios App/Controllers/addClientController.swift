//
//  addClientController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/22/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
import  FirebaseDatabase
class addClientController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBAction func addClient(_ sender: Any) {
        
        if (address.text == "") || (name.text == "") || (number.text == ""){
            let alert = UIAlertController(title: "Oh no!", message: "Something is missing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let newClient = Client()
            
            newClient.name = name.text!
            newClient.address = address.text!
            newClient.phoneNumber = number.text!
            newClient.lawyerId = Auth.auth().currentUser?.uid as! String
            newClient.email = email.text!
            
            fireServices.FIRBase.refClients.childByAutoId().setValue(newClient.convertToDict()) { (error, reference) in
                if error != nil{
                    print(error?.localizedDescription)
                }else{
                    print("job well done. Perfoming segues")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "homeController")
                    self.present(controller, animated: true, completion: nil)
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
