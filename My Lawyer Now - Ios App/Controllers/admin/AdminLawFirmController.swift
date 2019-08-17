//
//  AdminLawFirmController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase
class AdminLawFirmController: UIViewController {

    @IBOutlet weak var lawFirm: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if lawFirm.text == nil{
            let alert = UIAlertController(title: "Oh no!", message: "Please enter a valid Lawfirm.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.performSegue(withIdentifier: "toAdminTeam", sender: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let controller = segue.destination as? teamMembersController
        controller?.thisLawFirm.admin = Auth.auth().currentUser?.uid
        controller?.thisLawFirm.name = self.lawFirm.text!
    }
    

}
