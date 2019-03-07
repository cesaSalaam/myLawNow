//
//  phoneNumberController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/3/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class phoneNumberController: UIViewController {

    var name: String?
    var email: String?
    var password: String?
    var lawFirm: String?
    var templawyer: Lawyer?
    @IBOutlet weak var phoneNumber: UITextField!
    var refLawyers: DatabaseReference!
    
    override func viewWillAppear(_ animated: Bool) {
        print(name)
        print(email)
        print(password)
        print(lawFirm)
        
        
        self.phoneNumber.useUnderline()
        templawyer = Lawyer(name: name!,phoneNumber: phoneNumber.text!,email: email!,lawFirm: lawFirm!)
        refLawyers = Database.database().reference().child("Lawyers")
        print(templawyer?.convertToDict())
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        print((templawyer?.email)!)
        Auth.auth().createUser(withEmail: (templawyer?.email)!, password: password!) { (authResult, error) in
            if let err = error{
                print(err.localizedDescription)
                let alert = UIAlertController(title: "Oh no!", message: err.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                
                Auth.auth().signIn(withEmail: (self.templawyer?.email)!, password: self.password!) { [weak self] user, error in
                    guard let strongSelf = self else { return }
                    if let err = error{
                        print("there is an error")
                        print(err.localizedDescription)
                    } else{
                        print("well done")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let controller = storyboard.instantiateViewController(withIdentifier: "homeController")
                        self?.present(controller, animated: true, completion: nil)
                    }
                }
                let lawObject = self.templawyer!.convertToDict()
                
                self.refLawyers.child((Auth.auth().currentUser?.uid)!).setValue(lawObject, withCompletionBlock: { (error, reference) in
                    if let err = error{
                        print("there is an error")
                        print(err.localizedDescription)
                    }else{
                        print("added \(lawObject["name"]!) to database.")
                    }
                })
                
            }
        }
        
    }
    
    func performAction(input: String) {
        
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
                print("error calling GET on /todos/1")
                print(error!)
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
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
