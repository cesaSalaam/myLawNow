//
//  adminEmailController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class adminEmailController: UIViewController {
    @IBOutlet weak var email: UITextField!
    var thisLawFirm = lawFirm()
    var admin = Admin()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if (email.text?.isValidEmail())!{
            self.admin.email = email.text!
            self.performSegue(withIdentifier: "toAdminPassword", sender: nil)
        }else{
            let alert = UIAlertController(title: "Oh no!", message: "Please enter a valid email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? adminPasswordController
        print("lawFirm: \(self.thisLawFirm.numOfLawyers)")
        print("admin: \(self.admin.email)")
        controller?.thisLawFirm = self.thisLawFirm
        controller?.admin = self.admin
        
    }
    

}
