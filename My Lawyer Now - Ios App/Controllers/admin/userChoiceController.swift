//
//  userChoiceController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class userChoiceController: UIViewController {
    var handle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var adminButton: UIButton!
    
    @IBOutlet weak var lawyerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        adminButton.layer.cornerRadius = 3.0
        adminButton.layer.borderWidth = 1.0
        adminButton.layer.borderColor = hexStringToUIColor(hex: "0474bc").cgColor
        
        lawyerButton.layer.cornerRadius = 3.0
        lawyerButton.layer.borderWidth = 1.0
        lawyerButton.layer.borderColor = hexStringToUIColor(hex: "0474bc").cgColor
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // [START_EXCLUDE]
            
            if user != nil{
                print("a user is signed in")
                
                self.userIsAdministrator(uid: (Auth.auth().currentUser?.uid)!, completionHandler: { (value) in
                    if value == true{
                        print("This is an admin")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "adminHomeController")
                        self.present(controller, animated: true, completion: nil)
                    }else{
                        print("This user is a lawyer..")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "homeController")
                        self.present(controller, animated: true, completion: nil)
                    }
                })
                
            } else {
                //instantiate start view controller
                print("user not already logged in. Staying here.")
            }
            // [END_EXCLUDE]
        }
    }
    
    func userIsAdministrator(uid: String, completionHandler: @escaping (Bool)->()){
        fireServices.FIRBase.refAdmins.database.reference(withPath: "Administrators").observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.exists())
            for snap in (snapshot.value as? NSDictionary)!{
                print(Auth.auth().currentUser?.uid)
                let items = snap.value as? NSDictionary
                if items?["UID"] as? String == (Auth.auth().currentUser?.uid)!{
                    print("This user is an admin")
                   completionHandler(true)
                }
            }
            completionHandler(false)
        }
}
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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

