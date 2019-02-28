//
//  GruveoController.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/23/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit
import GruveoSDK
class GruveoController: UIViewController, GruveoCallManagerDelegate{
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        GruveoCallManager.setDelegate(self)
        
        GruveoCallManager.callCode("gruveorocks", videoCall: true, textChat: false, on: self) { (creationError) in
            if Int(creationError.rawValue) != 0{
                
            }
        }
    
    }
    
    
    func request(toSignApiAuthToken token: String!) {
        var request: NSMutableURLRequest? = nil
        if let url = URL(string: "https://api-demo.gruveo.com/signer") {
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
        var request: NSMutableURLRequest? = nil
        if let url = URL(string: "https://api-demo.gruveo.com/signer") {
            request = NSMutableURLRequest(url: url)
        }
        request?.httpMethod = "POST"
        request?.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        //request?.httpBody = token.data(using: .utf8)
        
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
