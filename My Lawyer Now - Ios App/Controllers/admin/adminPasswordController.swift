//
//  adminPasswordController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/25/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase
class adminPasswordController: UIViewController {

    @IBOutlet weak var password: UITextField!
    var thisLawFirm = lawFirm()
    var admin = Admin()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        if password.text!.count > 6{
            self.performSegue(withIdentifier: "toAdminPhoneNumber", sender: nil)
        } else {
            let alert = UIAlertController(title: "Hmm", message: "Let's make that password more than 6 characters.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? AdminPhoneNumberController
        print("lawFirm: \(self.thisLawFirm.numOfLawyers)")
        print("admin: \(self.admin.email)")
        controller?.admin = self.admin
        controller?.thisLawFirm = self.thisLawFirm
        controller?.password = self.password.text!
    }
    

}
