//
//  GruveoController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/23/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import GruveoSDK
class GruveoController: UIViewController, GruveoCallManagerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var clientNumber: UITextField!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        clientNumber.resignFirstResponder()  //if desired
        if (clientNumber.text?.count)! < 10{
            return false
        }else{
            performAction(input: clientNumber.text!)
            return true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func performAction(input: String) {
        
        /* This is to verify the phone number. Use for the signup process
         
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
        task.resume()*/
        
        
        let URL = NSURL(string: "http://mylawnow.herokuapp.com/call/room?id=\(input)")!
        
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
            /*guard let responseData = data else {
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
            }*/
        }
        task.resume()
        self.callClient()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GruveoCallManager.setDelegate(self)
        
        self.clientNumber.delegate = self
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(GruveoController.doneButtonAction))
        
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        //setting toolbar as inputAccessoryView
        self.clientNumber.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        if (clientNumber.text?.count)! < 10{
            return
        }else{
            self.view.endEditing(true)
            performAction(input: clientNumber.text!)
        }
    }
    
    func request(toSignApiAuthToken token: String!) {
        var request: NSMutableURLRequest? = nil
        
        /*if let url = URL(string: "https://api-demo.gruveo.com/signer") {
            request = NSMutableURLRequest(url: url)
        }*/
        if let url = URL(string: "http://mylawnow.herokuapp.com/signer") {
            request = NSMutableURLRequest(url: url)
        }
        request?.httpMethod = "POST"
        request?.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request?.httpBody = token.data(using: .utf8)
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        
        if let request = request {
            (session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                if (data != nil) {
                    var signedToken: String? = nil
                    if let data = data {
                        signedToken = String(data: data, encoding: .utf8)
                    }
                    GruveoCallManager.authorize(signedToken)
                } else {
                    GruveoCallManager.authorize(nil)
                }
            })).resume()
        }
    }
    
    
    func callClient(){
        GruveoCallManager.callCode("gruveorocks", videoCall: true, textChat: false, on: self) { (creationError) in
            if Int(creationError.rawValue) != 0{
                print("cool")
            }
        }
    }
    
    func callEstablished() {
        
    }
    
    func callEnd(_ reason: GruveoCallEndReason) {
        
    }
    
    func recordingStateChanged() {
        
    }
    
    func recordingFilename(_ filename: String!) {
        
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
