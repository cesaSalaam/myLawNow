//
//  SignUpViewController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/15/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class nameController: UIViewController{

    var refLawyers: DatabaseReference!
    @IBOutlet weak var name: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        self.name.useUnderline()
    }
    
    @IBAction func Next(_ sender: Any) {
        if (name.text?.count)! < 2{
            return
        }else{
        self.performSegue(withIdentifier: "toEmail", sender: nil)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! emailSignup
        controller.name = self.name.text!
    }
}
