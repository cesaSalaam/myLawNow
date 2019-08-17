//
//  emailSignup.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/3/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class emailSignup: UIViewController {

    var name: String?
    // MARK: - IBAction
    
    @IBOutlet weak var email: UITextField!
    override func viewWillAppear(_ animated: Bool) {
        self.email.useUnderline()
        print(name!)
    }
    
    
    @IBAction func nextClicked(_ sender: Any) {
        if (email.text?.isValidEmail())!{
            self.performSegue(withIdentifier: "toPassword", sender: nil)
        }else{
            let alert = UIAlertController(title: "Oh no!", message: "Please enter a valid email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! passwordController
        controller.name = self.name
        controller.email = self.email.text!
        
    }
 

}
