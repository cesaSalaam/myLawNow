//
//  Lawyer.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 2/15/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class Lawyer: NSObject {
    var name : String?
    var lawFirm : String?
    var email : String?
    var phoneNumber : String?
    var clients : [String?] = []
    
    func convertToDict()->[String:String]{
        /*var clientsString = String()
        if clients.isEmpty == true{
            print("it's nil")
            clientsString =  ""
        } else{
            for item in clients{
                clientsString.append("\(item)")
            }
        }*/
        
        return ["name":self.name! , "lawFirm":self.lawFirm! , "email": self.email! , "phoneNumber" : self.phoneNumber! ]
    }
    
}
