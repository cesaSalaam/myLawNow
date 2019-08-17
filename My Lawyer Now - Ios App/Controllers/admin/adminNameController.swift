//
//  adminNameController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase

class adminNameController: UIViewController {

    var thisLawFirm = lawFirm()
    var admin = Admin()
    @IBOutlet weak var name: UITextField!
    
    @IBAction func nextButtonClicker(_ sender: Any) {
        if self.name.text == nil{
            let alert = UIAlertController(title: "Oh no!", message: "Please enter a valid name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.admin.name = self.name.text
            self.admin.lawFirm = "\(Auth.auth().currentUser?.uid)-\(self.thisLawFirm.name!)"
            self.performSegue(withIdentifier: "toAdminEmail", sender: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? adminEmailController
        print("lawFirm: \(self.thisLawFirm.name)")
        print("admin: \(self.admin.name)")
        controller?.admin = self.admin
        controller?.thisLawFirm = self.thisLawFirm
    }
}
