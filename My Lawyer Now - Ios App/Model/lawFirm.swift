//
//  lawFirm.swift
//  My Lawyer Now - Ios App
//
//  Created by Cesa Salaam on 3/21/19.
//  Copyright © 2019 Cesa Salaam. All rights reserved.
//

import UIKit

class lawFirm: NSObject {
    var name: String?
    var admin: String?
    var lawyers: String?
    var numOfLawyers: String?
    
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
        
        return ["name":self.name! , "admin":self.admin! , "lawyers": self.lawyers! , "numOfLawyers" : self.numOfLawyers!]
    }
    
    init(name: String, admin: String, lawyers: String, numOfLawyers: String){
        self.name = name
        self.admin = admin
        self.lawyers = lawyers
        self.numOfLawyers = numOfLawyers
    }
    
    override init() {
        
    }
}
