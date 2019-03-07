//
//  passwordController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/3/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class passwordController: UIViewController {
    var name: String?
    var email: String?
    
    @IBOutlet weak var password: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.password.useUnderline()
        print(name)
        print(email)
        
    }
    
    @IBAction func nextClick(_ sender: Any) {
        if self.password.text!.count < 6 {
            let alert = UIAlertController(title: "Oh no!", message: "Password should be atleast six characters.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.performSegue(withIdentifier: "toFirm", sender: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! lawFirmController
        controller.email = self.email
        controller.name = self.name
        controller.password = self.password.text!
    }
 

}
