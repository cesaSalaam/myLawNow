//
//  Admin.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/13/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class Admin: NSObject {

    var lawFirm: String?
    var name: String?
    var email: String?
    var phoneNumber: String?
    var UID: String?
    
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
        
        return ["name":self.name! , "lawFirm":self.lawFirm! , "email": self.email! , "phoneNumber" : self.phoneNumber!, "UID": self.UID!]
    }
    
    init(name: String, phoneNumber: String, email: String, lawFirm: String, UID: String){
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.lawFirm = lawFirm
    }
    override init() {
        
    }
}
