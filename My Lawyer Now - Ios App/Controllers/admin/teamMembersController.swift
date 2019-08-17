//
//  teamMembersController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class teamMembersController: UIViewController {
    
    var thisLawFirm = lawFirm()

    @IBAction func nextButtonClicker(_ sender: Any) {
        if numberOfLawyers.text == nil{
            let alert = UIAlertController(title: "Oh no!", message: "Please enter a number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.thisLawFirm.numOfLawyers = self.numberOfLawyers.text
            self.performSegue(withIdentifier: "toAdminName", sender: nil)
        }
    }
    
    @IBOutlet weak var numberOfLawyers: UITextField!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? adminNameController
        print("lawFirm: \(self.thisLawFirm.name)")
        controller?.thisLawFirm = self.thisLawFirm
    }
    

}
