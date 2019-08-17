//
//  lawFirmController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/3/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class lawFirmController: UIViewController {
    var name: String?
    var email: String?
    var password: String?
    
    @IBOutlet weak var lawFirm: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.lawFirm.useUnderline()
        print("name: " + name!)
        print(email)
        print(password)
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        if self.lawFirm.text!.count < 3{
            let alert = UIAlertController(title: "Oh no!", message: "Hmm, Are you sure thats a real lawfirm?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.performSegue(withIdentifier: "toNumber", sender: nil)
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! phoneNumberController
        controller.email = self.email
        controller.name = self.name
        controller.password = self.password
        controller.lawFirm = self.lawFirm.text!
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
    
    
}
