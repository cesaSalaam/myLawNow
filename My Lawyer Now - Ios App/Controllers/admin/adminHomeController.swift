//
//  adminHomeController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/25/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import Firebase
import StoreKit
class adminHomeController: UIViewController,  UITableViewDataSource, UITableViewDelegate{
    var adminObject = [String:String]()
    var adminSettingsList = ["Account", "Members","Legal",]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "adminCell")
        cell?.textLabel?.text = adminSettingsList[indexPath.row]
        return cell!
    }
    
    @IBOutlet weak var nameLetter: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        self.nameLetter.sizeToFit()
        tableView.tableFooterView = UIView()
        adminObject = UserDefaults.standard.object(forKey: "admin") as! [String : String] //why is this not being saved?
        nameLetter.text = adminObject["name"]?.substring(toIndex: 1)
        print(nameLetter.text!)
        //backgroundView.layer.cornerRadius = backgroundView.frame.size.width * 0.5
         backgroundView.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        
        backgroundView.layer.borderColor = hexStringToUIColor(hex: "0474bc").cgColor
        backgroundView.layer.borderWidth = 2.0
        
        //self.backgroundView.layer.shadowRadius = self.backgroundView.frame.size.width / 2 + 5;
    }
    
    @IBAction func logOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "NavController")
            self.present(controller, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
