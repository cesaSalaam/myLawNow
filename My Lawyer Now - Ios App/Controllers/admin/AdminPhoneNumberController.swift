//
//  AdminPhoneNumberController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class AdminPhoneNumberController: UIViewController {
    var thisLawFirm = lawFirm()
    var admin = Admin()
    var pin: String?
    var password: String?
    
    @IBOutlet weak var phoneNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func nextClicked(_ sender: Any) {
        if (phoneNumber.text?.count)! < 10{
            let alert = UIAlertController(title: "Oh no!", message: "Please enter a valid phone number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            verifyCode(input: phoneNumber.text!, completionHandler: {
                print("performing")
                self.admin.phoneNumber = self.phoneNumber.text!
                self.performSegue(withIdentifier: "toAdminVerifyPhone", sender: nil)
            })
        }
    }
    
    func verifyCode(input: String, completionHandler: @escaping ()->Void){
        
        let URL = NSURL(string: "http://mylawnow.herokuapp.com/verify/sms?number=\(input)")!
        
        let urlRequest = URLRequest(url: URL as URL)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let link = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: String] else {
                        print("error trying to convert data to JSON")
                        return
                }
                print("code: " + link["code"]!)
                self.pin = link["code"]!
                DispatchQueue.main.async {
                    completionHandler()
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as? verificationController
        print("lawFirm: \(self.thisLawFirm.numOfLawyers)")
        print("admin: \(self.admin.phoneNumber)")
        controller?.admin = self.admin
        controller?.thisLawFirm = self.thisLawFirm
        controller?.pin = self.pin
        controller?.password = self.password!
    }
 

}
