//
//  StartViewController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/15/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        
        loginButton.layer.cornerRadius = 3.0
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = hexStringToUIColor(hex: "0474bc").cgColor
        
        signUpButton.layer.cornerRadius = 3.0
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = hexStringToUIColor(hex: "0474bc").cgColor
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
