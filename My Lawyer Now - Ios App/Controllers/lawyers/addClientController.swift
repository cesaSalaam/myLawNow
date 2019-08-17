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

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var name: UITextField!
    
    @IBAction func cancel(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "homeController")
        self.present(controller, animated: true, completion: nil)
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.name.useUnderline()
        self.number.useUnderline()
        self.address.useUnderline()
        self.email.useUnderline()
        self.registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.unregisterKeyboardNotifications()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(addClientController.keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addClientController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func keyboardDidShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        // Get the existing contentInset for the scrollView and set the bottom property to be the height of the keyboard
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = keyboardSize.height
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        var contentInset = self.scrollView.contentInset
        contentInset.bottom = 0
        
        self.scrollView.contentInset = contentInset
        self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
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
